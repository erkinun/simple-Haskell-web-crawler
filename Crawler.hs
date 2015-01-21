import System.Environment
import Network.HTTP
import Network.Browser

main = do 
  print "Crawler Main starting..."
  urls <- getArgs
  return $ checkUrls urls
  print $ head urls ++ " will be crawled"
  (_, rsp)
         <- Network.Browser.browse $ do
               setAllowRedirects True -- handle HTTP redirects
               request $ getRequest $ head urls
  print $ getLinks $ rspBody rsp

checkUrls :: [String] -> ()
checkUrls [] = error "supply an argument"
checkUrls urls 
          | length urls > 1 = error "supply just one url"
          | otherwise = ()

getLinks :: String -> [String]
getLinks str = [str]
