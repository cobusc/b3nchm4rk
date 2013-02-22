INSERT INTO TABLE hash_algorithm(name)
    VALUES ('sha256');

INSERT INTO TABLE asset_category(name, description)
    VALUES ('Property', 'Any type of property, e.g. a house, flat, plot, industrial land, etc.'),
           ('Investment', 'Any investments, e.g. savings account, money market'),
           ('Retirement Annuity', 'Retirement Annuity, Providend Fund, etc.'),
           ('Vehicle' , 'The value of your vehicle'),
           ('Shares', 'Shares'),
           ('Unit Trust', 'Unit Trust');

INSERT INTO TABLE liability_category(name, description)
    VALUES ('Bond/Mortgage', 'Money owed on you property'),
           ('Vehicle Finance', 'Money outstanding w.r.t. your vehicle, including residual'),
           ('Credit Card', 'Total owed on your credit card'),
           ('Overdraft', 'Overdraft'),
           ('Store Credit', 'Amount owed to a store');
