import System.Environment
import Network.HTTP
import Network.URI
import Network.Browser

main = do 
  print "Crawler Main starting..."
  print "Please type in a url to crawl: "
  urls <- getLine

  return $ checkUrls [urls]
  print $ urls ++ " will be crawled"

  (_, rsp) <- getPageContent urls

  print $ getLinks $ rspBody rsp
  main

checkUrls :: [String] -> ()
checkUrls [] = error "supply an argument"
checkUrls urls 
          | length urls > 1 = error "supply just one url"
          | otherwise = ()

getLinks :: String -> [String]
getLinks str = [str]

getPageContent :: String -> IO (Network.URI.URI, Response String)
getPageContent url = Network.Browser.browse $ do
               setAllowRedirects True -- handle HTTP redirects
               request $ getRequest $ url
