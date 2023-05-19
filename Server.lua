local scriptVersion = "1.0.0" -- Setze die aktuelle Version hier ein
local scriptName = "DeinName" -- Setze den Namen deines Scripts hier ein

local checkingInterval = 6000 -- Überprüfungsintervall in Sekunden
local versionCheckUrl = "http://deinewebadresse/deine.php" -- Setze die URL, um die neueste Version abzurufen

Citizen.CreateThread(function()
    while true do
        PerformHttpRequest(versionCheckUrl, function(errorCode, resultData, resultHeaders)
            if errorCode == 200 then
                local latestVersion = resultData:match("Version:%s*(%d+.%d+.%d+)")
                if latestVersion and latestVersion ~= scriptVersion then
                    print("^1[INFO] ^0Die Version von ^5" .. scriptName .. " ^0ist veraltet. Die neueste Version ist ^5" .. latestVersion)
                                else
                    Citizen.Wait(200)
                    print("^1[INFO] ^0Du hast die Version: ^6" .. scriptVersion .."^0 und bist somit auf dem neusten stand.")
                end
            else
                print("^2[ERROR] ^0Fehler beim Abrufen der Version: ^6" .. errorCode)
            end
        end, "GET", "", {})

        Citizen.Wait(checkingInterval * 1000)
    end
end)

