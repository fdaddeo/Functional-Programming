use std::any::Any;
use std::io::*;

pub trait EmergencyVehicle
{
    fn act(&mut self, new_position: Pt);
    fn get_id(&self) -> String;
    fn get_position(&self) -> Pt;
    fn get_speed(&self) -> f32;
    fn get_equipment_level(&self) -> i32;
    fn get_is_available(&self) -> bool;
    fn set_is_available(&mut self, is_available: bool);
    fn get_setup_time(&self) -> f32;
    fn as_any(&self) -> &dyn Any;
    fn get_response_time(&self, emergency_position: Pt ) -> f32;
}

#[derive(Copy, Clone, Debug)]
pub struct Pt 
{
    pub x: i32,
    pub y: i32
}
impl Pt
{
    pub fn new(x: i32, y: i32) -> Pt
    {
        Pt {x: x, y: y}
    }
}

pub struct Fleet
{
    pub vehicles: Vec<Box<dyn EmergencyVehicle>>
}
impl Fleet
{
    pub fn add_new_vehicle(&mut self, new_vehicle: Box<dyn EmergencyVehicle>)
    {
        let mut add_vehicle = true;

        for vehicle in self.vehicles.iter()
        {
            if new_vehicle.get_id() == vehicle.get_id() 
            { 
                add_vehicle = false;
                println!("Vehicle ID not unique. Please choose another ID.");
                
                break;
            }
        }

        if add_vehicle { self.vehicles.push(new_vehicle); }
    }

    pub fn respond_to_emergency(&mut self, emergency_position: Pt, emergency_level: i32)
    {
        let mut min_response_time: f32 = f32::INFINITY;
        let mut vehicle_idx: i32 = -1;
        let mut idx: i32 = 0;

        for vehicle in self.vehicles.iter()
        {
            if vehicle.get_is_available() && vehicle.get_equipment_level() >= emergency_level
            {
                let response_time = vehicle.get_response_time(emergency_position);

                if response_time < min_response_time
                {
                    vehicle_idx = idx;
                    min_response_time = response_time;
                }
            }

            idx += 1;
        }

        if vehicle_idx != -1
        {
            if let Some(ambulance) = self.vehicles[vehicle_idx as usize].as_any().downcast_ref::<Ambulance>()
            {
                println!("\nSending Ambulance - id: {}\n", ambulance.get_id());
            }
            
            if let Some(helicopter) = self.vehicles[vehicle_idx as usize].as_any().downcast_ref::<Helicopter>()
            {
                println!("\nSending Helicopter - id: {}\n", helicopter.get_id());
            }

            self.vehicles[vehicle_idx as usize].set_is_available(false);
            self.vehicles[vehicle_idx as usize].act(emergency_position);
        }
        else
        {
            println!("\nNo vehicle ready... sorry :(");
        }
    }

    pub fn end_emergency(&mut self, vehicle_id: String)
    {
        for vehicle in self.vehicles.iter_mut()
        {
            if vehicle.get_id() == vehicle_id
            {
                vehicle.set_is_available(true);

                if let Some(ambulance) = vehicle.as_any().downcast_ref::<Ambulance>()
                {
                    println!("\nEnding the emergency of Ambulance - id: {}\n", ambulance.get_id());
                }

                if let Some(helicopter) = vehicle.as_any().downcast_ref::<Helicopter>()
                {
                    println!("\nEnding the emergency Helicopter - id: {}\n", helicopter.get_id());
                }

                break;
            }
        }
    }

    pub fn get_fleet_info(&mut self)
    {
        for vehicle in self.vehicles.iter()
        {
            let position: Pt = vehicle.get_position();

            if let Some(_) = vehicle.as_any().downcast_ref::<Ambulance>()
            {
                println!("Ambulance - id: {} pos_x: {} pos_y: {} available: {} equipment: {}", vehicle.get_id(), position.x, position.y, vehicle.get_is_available(), vehicle.get_equipment_level());
            }
            else
            {
                println!("Helicopter - id: {} pos_x: {} pos_y: {} available: {} equipment: {}", vehicle.get_id(), position.x, position.y, vehicle.get_is_available(), vehicle.get_equipment_level());
            }
        }
    }
} 

pub struct Ambulance
{
    id: String,
    position: Pt,
    speed: f32,
    equipment_level: i32,
    is_available: bool,
    setup_time: f32
}
impl Ambulance
{
    pub fn new(id: String, position: Pt, equipment_level: i32) -> Ambulance
    {
        Ambulance {id: id, position: position, speed: 100.0, equipment_level: equipment_level, is_available: true, setup_time: 5.0 }
    }
}
impl EmergencyVehicle for Ambulance
{
    fn act(&mut self, new_position: Pt)
    {
        self.position = new_position;
    }

    fn get_id(&self) -> String { self.id.clone() }
    fn get_position(&self) -> Pt { self.position }
    fn get_speed(&self) -> f32 { self.speed }
    fn get_equipment_level(&self) -> i32 { self.equipment_level }
    fn get_is_available(&self) -> bool { self.is_available }
    fn set_is_available(&mut self, is_available: bool) { self.is_available = is_available; }
    fn get_setup_time(&self) -> f32 { self.setup_time }
    fn as_any(&self) -> &dyn Any { self }

    fn get_response_time(&self, emergency_position: Pt ) -> f32
    {
        let distance: f32 = ((self.position.x - emergency_position.x).abs() + (self.position.y - emergency_position.y).abs()) as f32;
        let response_time: f32 = (distance / self.speed) * 60.0 + self.setup_time;

        response_time
    }
}

pub struct Helicopter
{
    id: String,
    position: Pt,
    speed: f32,
    equipment_level: i32,
    is_available: bool,
    setup_time: f32
}
impl Helicopter
{
    pub fn new(id: String, position: Pt, equipment_level: i32) -> Helicopter
    {
        Helicopter {id: id, position: position, speed: 250.0, equipment_level: equipment_level, is_available: true, setup_time: 0.0 }
    }
}
impl EmergencyVehicle for Helicopter
{
    fn act(&mut self, new_position: Pt)
    {
        self.position = new_position;
    }

    fn get_id(&self) -> String { self.id.clone() }
    fn get_position(&self) -> Pt { self.position }
    fn get_speed(&self) -> f32 { self.speed }
    fn get_equipment_level(&self) -> i32 { self.equipment_level }
    fn get_is_available(&self) -> bool { self.is_available }
    fn set_is_available(&mut self, is_available: bool) { self.is_available = is_available; }
    fn get_setup_time(&self) -> f32 { self.setup_time }
    fn as_any(&self) -> &dyn Any { self }

    fn get_response_time(&self, emergency_position: Pt ) -> f32
    {
        let distance: f32 = ((((self.position.x - emergency_position.x).pow(2) + (self.position.y - emergency_position.y).pow(2)) as f32).sqrt()) as f32;
        let response_time: f32 = (distance / self.speed) * 60.0 + self.setup_time;

        response_time
    }
}

fn main()
{
    let mut fleet = Fleet{ vehicles: vec![ Box::new(Ambulance::new(String::from("amb1"), Pt::new(0, 0), 1)),
                                           Box::new(Ambulance::new(String::from("amb2"), Pt::new(2, 2), 2)),
                                           Box::new(Helicopter::new(String::from("heli1"), Pt::new(40, 23), 3))] 
                         };
    
    loop
    {
        println!("\nPrinting emergency fleet info ...\n");
        fleet.get_fleet_info();

        println!("\nWhat to do next? Type 'ADD' to add a new emergency vehicle to the fleet. Type 'SEND' to send an emergency vehicle. Type 'END' to end an emergency");
        let action: String = stdin().lock().lines().next().unwrap().unwrap();

        if action == String::from("ADD")
        {
            println!("\nAdding new emergency vehicle. Type 0 for ambulance, or 1 for helicopter");
            let vehicle_type: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();

            if vehicle_type != 0 && vehicle_type != 1
            {
                println!("Error in vehicle type");
                continue;
            }

            println!("Type the emergency vehicle ID:");
            let vehicle_id: String = stdin().lock().lines().next().unwrap().unwrap();
            
            println!("Where is located the new emergency vehicle?");
            println!("x val: ");
            let vehicle_x: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();
            println!("y val: ");
            let vehicle_y: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();

            println!("What is the equipment level of the new emergency vehicle?");
            let vehicle_equipment: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();

            if vehicle_equipment < 0 && vehicle_equipment > 3
            {
                println!("Error in vehicle equipment");
                continue;
            }

            if vehicle_type == 0
            {
                fleet.add_new_vehicle(Box::new(Ambulance::new(vehicle_id, Pt::new(vehicle_x, vehicle_y), vehicle_equipment)));
            }
            else
            {
                fleet.add_new_vehicle(Box::new(Helicopter::new(vehicle_id, Pt::new(vehicle_x, vehicle_y), vehicle_equipment)));
            }
        }
        else if action == String::from("SEND")
        {
            println!("\nWhere is the emergency?");
            println!("x val: ");
            let x_pos: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();
            println!("y val: ");
            let y_pos: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();
            println!("Emergency level [0 - 3]: ");
            let emergency_level: i32 = stdin().lock().lines().next().unwrap().unwrap().parse().unwrap();

            fleet.respond_to_emergency(Pt::new(x_pos, y_pos), emergency_level);
        }
        else if action == String::from("END")
        {
            println!("\nEnding the emergency ...");
            println!("Type the vehicle id: ");
            let vehicle_id: String = stdin().lock().lines().next().unwrap().unwrap();
            
            fleet.end_emergency(vehicle_id);
        }
        else
        {
            println!("\nValue inserted not found!\n");
            continue;
        }
    }
}