public Class CheckManifestRecursion{
    public static Boolean run = true;
    public static Boolean runOnce(){
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }
}