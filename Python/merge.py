def merge(v1: list, b1, e1,  # beg, end
          v2: list, b2, e2) -> list:
    """
    Merge generator. Takes two sorted sequences and produces a sorted sequence, with all the elements.

    :param v1: The first sorted sequence.
    :param b1: Begin index for the first sequence.
    :param e1: End index for the first sequence.
    :param v2: The second sorted sequence.
    :param b2: Begin index for the second sequence.
    :param e2: End index for the second sequence.
    """
    
    while b1 < e1 or b2 < e2:
        if b1 < e1 and (b2 == e2 or v1[b1] <= v2[b2]):
            yield(v1[b1]) 
            b1 += 1
        else:
            yield(v2[b2])
            b2 += 1