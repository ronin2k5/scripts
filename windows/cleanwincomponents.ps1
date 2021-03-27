Get-WindowsOptionalFeature -Online | where { $_.State -match "Disabled" } | `
    foreach { `
        $_ = $_.FeatureName; `
        DISM /Online /Disable-Feature /FeatureName:$_ /Remove `
    }
