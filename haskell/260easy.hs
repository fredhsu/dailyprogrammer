input = ["button_clicked",
        "cycle_complete",
        "button_clicked",
        "button_clicked",
        "button_clicked",
        "button_clicked",
        "button_clicked",
        "cycle_complete"]

data State = Open | Closed | Opening | Closing | StoppedClosing | StoppedOpening

command _ [] = []
command Closed ("button_clicked":xs) = ["> Button clicked.", "Opening"] ++ command Opening xs
command Opening ("button_clicked":xs) = ["> Button clicked.", "Stopped_While_Opening"] ++ command StoppedOpening xs
command StoppedOpening ("button_clicked":xs) = ["> Button clicked.", "Closing"] ++ command Closing xs
command Opening ("cycle_complete":xs) = ["> Cycle Complete.", "Open"] ++ command Open xs

command Open ("button_clicked":xs) = ["> Button clicked.", "Closing"] ++ command Closing xs
command Closing ("button_clicked":xs) = ["> Button clicked.", "Stopped_While_Closing"] ++ command StoppedClosing xs
command StoppedClosing ("button_clicked":xs) = ["> Button clicked.", "Opening"] ++ command Opening xs
command Closing ("cycle_complete":xs) = ["> Cycle Complete.", "Closed"] ++ command Closed xs

start = command Closed input
