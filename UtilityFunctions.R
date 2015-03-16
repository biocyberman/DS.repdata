# Utility functions
# Set server to download additional package. We choose to download from
# a server in Denmark (Aalborg) here.
my_mirror = "http://mirrors.dotsrc.org/cran/"
required_package <- function(name = NULL, src = "bioc"){
    src = tolower(src)
    if (!(src %in% c("cran", "bioc"))) {
        stop("Unkown source for installation: ", src)
    }
    mirror = NULL
    # First check if package installed, if not, just install it
    if (!is.element(name, installed.packages()[,1])) {
        if ("cran" == src){
            mirror = my_mirror
            message("Installing ", name, " package from ", mirror)
            install.packages(name, repos = mirror)
        } else if ("bioc" == src) {
            mirror = "http://bioconductor.org/biocLite.R"
            message("Installing ", name, " package from Bioconductor")
            source(mirror)
            biocLite(name, ask = FALSE)           ## R version 3.0 or later
        }   
    }
    # Next import the package, if this fails then something wrong.
    if (!require(package = name, character.only = TRUE, quietly = TRUE)){
        stop("Package ", name, " not found and installation attempt failed.") 
    }
}

