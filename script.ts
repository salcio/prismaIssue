import {PrismaClient} from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
    if (!(await prisma.user.findFirst({where: {name: 'Alice'}}))) {
        const user = await prisma.user.create({
            data: {
                id: '9771e3b4-2508-4531-9012-1932064acef2',
                name: 'Alice',
                email: 'alice@prisma.io',
                username: 'alice',
                createdBy: 'as',
                providerId: 'asdf'
            },
        })
        console.log(user);
    }
    if (!(await prisma.group.findFirst({where: {name: 'ApplicationGroup'}}))) {
        const user = await prisma.group.create({
            data: {
                id:'8771e3b4-2508-4531-9012-1932064acef1',
                name: 'ApplicationGroup',
                createdBy: 'as',
                providerId: 'asdf',
                order: 100,
                users:{create:[{userId:'9771e3b4-2508-4531-9012-1932064acef2',assignedBy:'a' }]},
                application:{create:{
                    name:'Application',
                        createdBy:'a',
                    }},
                managedGroups: {
                    create: [{
                        group: {
                            create: {
                                name: 'Group',
                                createdBy: 'as',
                                providerId: 'asdf1',
                                order: 100,
                            }
                        },
                        assignedBy:'a'
                    }]
                },
            },
        });
        await prisma.application.update({where:{id:user.applicationId!}, data:{
            owners:{create:[{groupId:user.id, assignedBy:'a'}]},
            }})
        console.log(user);
    }
    console.log('-----======== Get all user groups where user name is Alice =======-----');
    console.log(await prisma.userGroups.findMany({where: {user: {name: 'Alice'}}}));
    console.log('-----======== Count all user groups where user name is Alice - directly from usersGroups table =======-----');
    try {
        console.log(await prisma.userGroups.count({where: {user: {name: 'Alice'}}}));
        console.log(await prisma.userGroups.aggregate({_count: {_all: true}, where: {user: {name: 'Alice'}}}));
    } catch (e) {
        console.log(e);
    }
    console.log('-----======== Count all user groups where user name is Alice - from user record =======-----');
    console.log(await prisma.user.findMany({where: {name: 'Alice'}, select: {_count: {select: {groups: true}}}}));
    console.log('-----======== Get all users groups that belong to an aplication in which user is the owner =======-----');
    try {
        console.log(await prisma.userGroups.findMany({
            where: {
                group: {
                    application: {
                        owners: {
                            some: {
                                group: {
                                    users: {
                                        some: {
                                            userId: '9771e3b4-2508-4531-9012-1932064acef2'
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            },
        }));
    } catch (e) {
        console.log(e);
    }
    console.log('-----======== Get all groups that belong to an application in which user is the owner =======-----');
    console.log(await prisma.group.findMany({
        where: {
            application: {
                owners: {
                    some: {
                        group: {
                            users: {
                                some: {
                                    userId: '9771e3b4-2508-4531-9012-1932064acef2'
                                }
                            }
                        }
                    }
                }
            }
        },
    }));
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })
