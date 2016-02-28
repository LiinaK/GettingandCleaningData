## The first function should cache a matrix and the second one compute the
## inverse of said matrix. If the original matrix hasn't changed, we get the inverse of the matrix previously fed into the function.

## makeCachematrix creates the function and holds four subfunctions.

makeCacheMatrix <- function(x = matrix()) {  ## creates the function makeCacheMatrix, which below will be called "mCM" for short.
    n <- NULL
    set <- function(y){ ## set changes the matrix in the mCM
    x <<- y            ## these two lines should set values to x and n, readable also from environment of other function
    n <<- NULL
}
get <- function() x  ## for getting matrix x stored in the mCM, hopefully
setMyMatrix <- function (inversion) n <<- inversion ## should store the value of the variable "n" in mCM
getMyMatrix <- function() n
list(set = set, get = get, setMyMatrix = setMyMatrix, getMyMatrix = getMyMatrix) ## make findable for mCM 
}

## This function inverts the matrix and returns it, it also checks to see if we changed matrices and then acts on that if we did

cacheSolve <- function(x, ...) {
    n <- x$getMySolution() ##these three lines should verify the value of "n"
    if(!is.null(n)) { ## and make sure it isn't NULL, and oh, get the value if need be
        return(n)
    }
    data <- x$get()    ##creates object "data" and stores value from x in mCM
    invertedMatrix <- solve(data) ##using the data from above and actually calculating the inverted matrix and stores it into object "invertedMatrix"
    x$setMyMatrix(invertedMatrix) 
    invertedMatrix  
}
