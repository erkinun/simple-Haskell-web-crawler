import System.Environment
import Network.HTTP
import Network.URI
import Network.Browser
import Text.Regex.Posix

main = do 
  print "Crawler Main starting..."
  print "Please type in a url to crawl: "
  urls <- getLine

  return $ checkUrls [urls]
  print $ urls ++ " will be crawled"

  (_, rsp) <- getPageContent urls

  print $ getHref $ head $ getLinks $ rspBody rsp
  main

checkUrls :: [String] -> ()
checkUrls [] = error "supply an argument"
checkUrls urls 
          | length urls > 1 = error "supply just one url"
          | otherwise = ()

getLinks :: String -> [String]
getLinks str = getAllTextMatches $ str =~ "<a.*>.*</a>" :: [String]

getHref :: String -> String
getHref [] = "empty link"
getHref url  = init $ drop 6 $ head href
                where href = getAllTextMatches $ url =~ "href=\"[a-zA-Z0-9:/\\.]*\"" :: [String]

getPageContent :: String -> IO (Network.URI.URI, Response String)
getPageContent url = Network.Browser.browse $ do
               setAllowRedirects True -- handle HTTP redirects
               request $ getRequest $ url
