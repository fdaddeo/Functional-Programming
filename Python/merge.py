def merge(v1: list, b1, e1,  # beg, end
          v2: list, b2, e2) -> list:
    while b1 < e1 or b2 < e2:
        if b1 < e1 and (b2 == e2 or v1[b1] <= v2[b2]):
            yield(v1[b1]) 
            b1 += 1
        else:
            yield(v2[b2])
            b2 += 1