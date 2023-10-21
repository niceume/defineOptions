pkg = "defineOptions"

# If RUnit and datasailr exist on this system, load and attach them. Then, run test.
if(requireNamespace("RUnit", quietly = TRUE) && 
   requireNamespace("defineOptions", quietly = TRUE )){

  # Test suit definition & Run tests.
  testSuite <- RUnit::defineTestSuite( name = paste0( pkg, " Unit Tests") , 
             dir = system.file("unit_tests", package = pkg ), 
             testFileRegexp = "^test_.+\\.[rR]$",
             testFuncRegexp = "^test_.+")
  Sys.setenv("R_TESTS"="")
  tests <- RUnit::runTestSuite(testSuite)
  RUnit::printTextProtocol(tests)
}
