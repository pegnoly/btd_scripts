BLUEPRINTS_SPECIAL = {
    [TOWN_ACADEMY] = {
        path = "/Text/Game/TownBuildings/Academy/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 9,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1, [TOWN_BUILDING_DWELLING_4] = 1},
            upgrades = {
                [1] = {
                    name = "Special_1/Name.txt",
                    cost = {
                        [MERCURY] = 2,
                        [CRYSTAL] = 2,
                        [SULFUR] = 2,
                        [GEM] = 2,
                        [GOLD] = 3000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 1,
                        [CRYSTAL] = 1,
                        [SULFUR] = 1,
                        [GEM] = 1,
                        [GOLD] = 2000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 5,
            depends_on = {[TOWN_BUILDING_MARKETPLACE] = 1},
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 2500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 11,
            depends_on = {[TOWN_BUILDING_DWELLING_5] = 1},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [GOLD] = 2750
                    }
                }
            }
        }
    },
    --
    [TOWN_DUNGEON] = {
        path = "/Text/Game/TownBuildings/Dungeon/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Special_1/Name.txt",
                    cost = {
                        [MERCURY] = 3,
                        [CRYSTAL] = 3,
                        [SULFUR] = 3,
                        [GEM] = 3,
                        [GOLD] = 2000
                    }
                },
                [2] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 3000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 5,
            depends_on = {[TOWN_BUILDING_DWELLING_2] = 1},
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [CRYSTAL] = 2,
                        [SULFUR] = 3,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 5,
            depends_on = {[TOWN_BUILDING_MARKETPLACE] = 1},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_6] = {
            town_level = 9,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_6/Name.txt",
                    cost = {
                        [GOLD] = 1500
                    }
                }
            }
        },
    },
    ---
    [TOWN_FORTRESS] = {
        path = "/Text/Game/TownBuildings/Dwarves/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_1/Runic_Shrine_1_Name.txt",
                    cost = {
                        [WOOD] = 1,
                        [ORE] = 1,
                        [MERCURY] = 1,
                        [CRYSTAL] = 1,
                        [SULFUR] = 1,
                        [GEM] = 1,
                        [GOLD] = 1000
                    }
                },
                [2] = {
                    name = "Special_1/Runic_Shrine_2_Name.txt",
                    cost = {
                        [WOOD] = 2,
                        [ORE] = 2,
                        [MERCURY] = 3,
                        [CRYSTAL] = 3,
                        [SULFUR] = 3,
                        [GEM] = 3,
                        [GOLD] = 4000
                    }
                },
                [3] = {
                    name = "Special_1/Runic_Shrine_3_Name.txt",
                    cost = {
                        [WOOD] = 3,
                        [ORE] = 3,
                        [MERCURY] = 5,
                        [CRYSTAL] = 5,
                        [SULFUR] = 5,
                        [GEM] = 5,
                        [GOLD] = 6000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 8,
            depends_on = {[TOWN_BUILDING_DWELLING_4] = 1},
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 0,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 16,
            depends_on = {[TOWN_BUILDING_FORT] = 3},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_5] = {
            town_level = 1,
            depends_on = {[TOWN_BUILDING_DWELLING_5] = 1},
            upgrades = {
                [1] = {
                    name = "Special_5/Name.txt",
                    cost = {
                        [GOLD] = 1500
                    }
                }
            }
        }
    },
    ------
    [TOWN_HEAVEN] = {
        path = "/Text/Game/TownBuildings/Haven/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_1/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [SULFUR] = 5,
                        [GOLD] = 3500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_SPECIAL_1] = 1},
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [MERCURY] = 8,
                        [SULFUR] = 8,
                        [GOLD] = 5000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 9,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [GOLD] = 2000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_5] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_DWELLING_1] = 1},
            upgrades = {
                [1] = {
                    name = "Special_5/Name.txt",
                    cost = {
                        [GOLD] = 1000
                    }
                }
            }
        }
    },
    -----
    [TOWN_INFERNO] = {
        path = "/Text/Game/TownBuildings/Inferno/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_1/Name.txt",
                    cost = {
                        [MERCURY] = 2,
                        [SULFUR] = 2,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 6,
            depends_on = {[TOWN_BUILDING_DWELLING_2] = 1},
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [SULFUR] = 2,
                        [GOLD] = 1300
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 12,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [MERCURY] = 1,
                        [CRYSTAL] = 1,
                        [SULFUR] = 1,
                        [GEM] = 1,
                        [GOLD] = 5000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 11,
            depends_on = {[TOWN_BUILDING_DWELLING_5] = 1},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [SULFUR] = 4,
                        [GOLD] = 1500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_5] = {
            town_level = 5,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_5/Name.txt",
                    cost = {
                        [MERCURY] = 2,
                        [CRYSTAL] = 2,
                        [SULFUR] = 2,
                        [GEM] = 2,
                        [GOLD] = 3000
                    }
                }
            }
        }
    },
    -----
    [TOWN_NECROMANCY] = {
        path = "/Text/Game/TownBuildings/Necromancy/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 5,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_/Name.txt",
                    cost = {
                        [SULFUR] = 10,
                        [GOLD] = 1000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 17,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [ORE] = 15,
                        [GOLD] = 3000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 6,
            depends_on = {[TOWN_BUILDING_DWELLING_1] = 1},
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [SULFUR] = 3,
                        [GOLD] = 500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 12,
            depends_on = {[TOWN_BUILDING_DWELLING_7] = 1},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [MERCURY] = 4,
                        [SULFUR] = 3,
                        [GOLD] = 3000
                    }
                }
            }
        }
    },   
    -----
    [TOWN_PRESERVE] = {
        path = "/Text/Game/TownBuildings/Preserve/",
        [TOWN_BUILDING_SPECIAL_0] = {
            town_level = 9,
            depends_on = {[TOWN_BUILDING_DWELLING_3] = 1},
            upgrades = {
                [1] = {
                    name = "Special_0/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 1000
                    }
                },
                [2] = {
                    name = "Special_1/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 2000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_MARKETPLACE] = 1},
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [GEM] = 3,
                        [GOLD] = 500
                    }
                },
                [2] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [MERCURY] = 5,
                        [GOLD] = 250
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_DWELLING_1] = 1},
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [CRYSTAL] = 5,
                        [GOLD] = 500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_5] = {
            town_level = 11,
            depends_on = {[TOWN_BUILDING_DWELLING_6] = 1},
            upgrades = {
                [1] = {
                    name = "Special_5/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [GOLD] = 3000
                    }
                }
            }
        }
    },
    -------
    [TOWN_STRONGHOLD] = {
        path = "/Text/Game/TownBuildings/StrongHold/",
        [TOWN_BUILDING_SPECIAL_1] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_1/Hall_of_Trial_1_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [GOLD] = 2000
                    }
                },
                [2] = {
                    name = "Special_1/Hall_of_Mastership_2_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 2,
                        [CRYSTAL] = 2,
                        [SULFUR] = 2,
                        [GEM] = 2,
                        [GOLD] = 3000
                    }
                },
                [3] = {
                    name = "Special_1/Hall_of_Might_3_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 4,
                        [CRYSTAL] = 4,
                        [SULFUR] = 4,
                        [GEM] = 4,
                        [GOLD] = 4000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_2] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_DWELLING_1] = 1},
            upgrades = {
                [1] = {
                    name = "Special_2/Name.txt",
                    cost = {
                        [WOOD] = 1,
                        [ORE] = 1,
                        [MERCURY] = 1,
                        [SULFUR] = 1,
                        [GOLD] = 100
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_3] = {
            town_level = 9,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_3/Name.txt",
                    cost = {
                        [WOOD] = 4,
                        [ORE] = 4,
                        [MERCURY] = 1,
                        [CRYSTAL] = 1,
                        [SULFUR] = 1,
                        [GEM] = 1,
                        [GOLD] = 1500
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_4] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_4/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [MERCURY] = 4,
                        [SULFUR] = 4,
                        [GOLD] = 2000
                    }
                }
            }
        },
        [TOWN_BUILDING_SPECIAL_5] = {
            town_level = 5,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Special_5/Name.txt",
                    cost = {
                        [WOOD] = 4,
                        [ORE] = 4,
                        [CRYSTAL] = 2,
                        [GEM] = 2,
                        [GOLD] = 1000
                    }
                }
            }
        }
    }
}