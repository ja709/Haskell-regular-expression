# Haskell-regular-expression

data RE a            -- regular expressions over an alphabet defined by 'a'
    = Empty          -- empty regular expression
    | Sym a          -- match the given symbol
    | RE a :+: RE a  -- concatenation of two regular expressions
    | RE a :|: RE a  -- choice between two regular expressions
    | Rep (RE a)     -- zero or more repetitions of a regular expression
    | Rep1 (RE a)    -- one or more repetitions of a regular expression
    deriving (Show)


- matchEmpty :: RE a -> Bool

    This function returns true if the regular expression matches an empty
    string. Note that the type does not include any constraints on the alphabet.
    Among other things, this means that will not be able to use the matches
    function we defined in class, as it requires 'a' to be an instance of Eq.
    
    Some examples:
    
    matchEmpty (Sym 'a') = False
    matchEmpty (Rep (Sym 'a' :+: Sym 'b')) = True
    matchEmpty (Rep1 (Sym 'a' :|: Empty)) = True


- firstMatches :: RE a -> [a]

    Given a regular expression r, return a list of all symbols that occur first
    in some string in the language described by r. You are not required to
    eliminate duplicates (since nothing is known about the alphabet, doing so
    would be impossible), but the list should be finite. No particular order
    is required.
    
    Some examples:
    
    firstMatches (Sym 'a') = ['a']
    firstMatches (Rep (Sym 'a' :|: Sym 'b')) = ['a', 'b']
    firstMatches (Sym 1 :+: Sym 2) = [1]
    firstMatches ((Sym 1 :|: Empty) :+: Sym 2) = [1,2]

# Haskell-regular-expression
