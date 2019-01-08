module Project where 

data RE a            -- regular expressions over an alphabet defined by 'a'
    = Empty          -- empty regular expression
    | Sym a          -- match the given symbol
    | RE a :+: RE a  -- concatenation of two regular expressions
    | RE a :|: RE a  -- choice between two regular expressions
    | Rep (RE a)     -- zero or more repetitions of a regular expression
    | Rep1 (RE a)    -- one or more repetitions of a regular expression
    deriving (Show)



matchEmpty :: RE a -> Bool
matchEmpty Empty = True

matchEmpty (Sym a) = False	
matchEmpty (Rep a) = True
--matchEmpty (Rep1 a) = False

matchEmpty (a :+: b) = (matchEmpty a) && (matchEmpty b)

matchEmpty (a :|: b) = (matchEmpty a) || (matchEmpty b)


--matchEmpty (Rep (a :|: b)) = (matchEmpty a) || (matchEmpty b)
--matchEmpty (Rep (a :+: b)) = (matchEmpty a) && (matchEmpty b)
matchEmpty (Rep a) = matchEmpty a
matchEmpty (Rep1 a) = matchEmpty a
--matchEmpty (Rep1 (a :|: b)) = (matchEmpty a) || (matchEmpty b)
--matchEmpty (Rep1 (a :+: b)) = (matchEmpty a) && (matchEmpty b)



{-
    This function returns true if thes regular expression matches an empty
    string. Note that the type does not include any constraints on the alphabet.
    Among other things, this means that will not be able to use the matches
    function we defined in class, as it requires 'a' to be an instance of Eq.
    
    Some examples:
    
    matchEmpty (Sym 'a') = False
    matchEmpty (Rep (Sym 'a' :+: Sym 'b')) = True
    matchEmpty (Rep1 (Sym 'a' :|: Empty)) = True

-}



firstMatches :: RE a -> [a]

firstMatches Empty = []
firstMatches (Sym a) = [a]	
firstMatches (a :+: b) = firstMatches a ++ (if (matchEmpty a) then (firstMatches b) else [])  
firstMatches (a :|: b) = firstMatches a ++ firstMatches b ++ firstMatches Empty
firstMatches (Rep a) = firstMatches a
firstMatches (Rep1 a) = firstMatches a 

{-
    Given a regular expression r, return a list of all symbols that occur first
    in some string in the language described by r. You are not required to
    eliminate duplicates (since nothing is known about the alphabet, doing so
    would be impossible), but the list should be finite. No particular order
    is required.
    
    Some examples:
    
    firstMatch (Sym 'a') = ['a']
    firstMatch (Rep (Sym 'a' :|: Sym 'b')) = ['a', 'b']
    firstMatch (Sym 1 :+: Sym 2) = [1]
    firstMatch ((Sym 1 :|: Empty) :+: Sym 2) = [1,2]
-}
