print("Hallo vanaf GitHub!")
game.Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " is toegevoegd!")
end)