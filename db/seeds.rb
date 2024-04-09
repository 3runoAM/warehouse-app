Supplier.create(corporate_name: 'BRN ltd', brand_name: 'BRN', registration_number: '453354564',
                                  city: 'Patos', state: 'Paraíba', full_address: 'Rua x, 123',
                                  email: 'brn@email.com')
Supplier.create(corporate_name: 'THK ltd', brand_name: 'THK', registration_number: '489489875',
                                   city: 'Cajazeiras', state: 'Paraíba', full_address: 'Rua y, 567',
                                   email: 'thk@gmail.com')
Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida das estrelas, 5000', CEP: '15000-00',
                                    description: 'Galpão para armazenamento')
Warehouse.create(name: 'Patos', code: 'PTS', city: 'Patos', area: 60_000,
                                     address: 'Avenida dos meteoros, 52000', CEP: '58000-00',
                                     description: 'Galpão para venda')