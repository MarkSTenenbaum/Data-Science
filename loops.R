## While loop (specifies logical expressions) -------------------------------------
# Abstract
while(abc){          # As long as ABC is true, it will conduct XYZ; it will cease once false 
  xyz
}

# Example
while(TRUE){
  print("hello")      # This will go on forever since "T" is always "T"
}


# Example 
counter <- 1 
while(counter < 12) {   # This will loop until counter gets to 12
  print(counter)
  counter <- counter +1
}


## For loop (specify interations) --------------------------------------------
for(i in 1:5){          # Rather than specifying logical expression, these loops specify iteration of loop
  print("Hello R")      # This will print "Hello R" five times
}




## If statements -------------------------------------------------------------
x <- rnorm(1)
if(x >1){                # logical expression (like while loop) but only runs once
  answer <- '>1'
  print(answer)
} else {
  answer <- '<=1'
  print(answer)
}

# More complicated example (nested statement...not advised)
x <- rnorm(1)
if(x >1){               
  answer <- 'Greater than 1'
  print(answer)
} else {
  if(x >= -1) {
  answer <- 'Between -1 and 1'
  print(answer)
  } else{
    answer <- 'less than -1'
    print(answer)
  }
}

# More complicated statement (chain statement...advised)
x <- rnorm(1)
if(x >1) {
  answer <- 'Greater than 1'
  print(answer)
 } else if(x >= -1){
    answer <- 'Between -1 and 1'
    print(answer)
 } else {
  answer <- 'Less than -1'
  print(answeR)
}



