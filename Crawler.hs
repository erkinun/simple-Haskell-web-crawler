import System.Environment

main = do 
  print "Crawler Main starting..."
  urls <- getArgs
  return $ checkUrls urls
  print $ head urls ++ " will be crawled"

checkUrls :: [String] -> ()
checkUrls [] = error "supply an argument"
checkUrls urls 
          | length urls > 1 = error "supply just one url"
          | otherwise = ()
