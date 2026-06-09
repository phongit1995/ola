.class public Lchat/ola/vn/w/cc;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# static fields
.field static e:[Lchat/ola/vn/w/bb;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    if-nez v0, :cond_0

    const/16 v0, 0x64

    new-array v0, v0, [Lchat/ola/vn/w/bb;

    sput-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x1

    new-instance v2, Lchat/ola/vn/w/ca;

    invoke-direct {v2}, Lchat/ola/vn/w/ca;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x2

    new-instance v2, Lchat/ola/vn/w/bv;

    invoke-direct {v2}, Lchat/ola/vn/w/bv;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x3

    new-instance v2, Lchat/ola/vn/w/bz;

    invoke-direct {v2}, Lchat/ola/vn/w/bz;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x4

    new-instance v2, Lchat/ola/vn/w/bs;

    invoke-direct {v2}, Lchat/ola/vn/w/bs;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x7

    new-instance v2, Lchat/ola/vn/w/bw;

    invoke-direct {v2}, Lchat/ola/vn/w/bw;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x6

    new-instance v2, Lchat/ola/vn/w/bu;

    invoke-direct {v2}, Lchat/ola/vn/w/bu;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/16 v1, 0xc

    new-instance v2, Lchat/ola/vn/w/cb;

    invoke-direct {v2}, Lchat/ola/vn/w/cb;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/16 v1, 0xd

    new-instance v2, Lchat/ola/vn/w/by;

    invoke-direct {v2}, Lchat/ola/vn/w/by;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/16 v1, 0xe

    new-instance v2, Lchat/ola/vn/w/bx;

    invoke-direct {v2}, Lchat/ola/vn/w/bx;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/16 v1, 0xf

    new-instance v2, Lchat/ola/vn/w/bt;

    invoke-direct {v2}, Lchat/ola/vn/w/bt;-><init>()V

    aput-object v2, v0, v1

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    const/16 v1, 0x10

    new-instance v2, Lchat/ola/vn/w/cd;

    invoke-direct {v2}, Lchat/ola/vn/w/cd;-><init>()V

    aput-object v2, v0, v1

    :cond_0
    return-void
.end method

.method public static a(S)S
    .locals 1

    const/4 v0, 0x1

    if-eq p0, v0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_0
    const/4 p0, 0x2

    return p0
.end method

.method public static b(S)S
    .locals 1

    const/4 v0, 0x2

    if-eq p0, v0, :cond_0

    const/4 p0, 0x0

    return p0

    :cond_0
    const/4 p0, 0x1

    return p0
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 2

    iget-object v0, p1, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const/16 v0, 0x8a

    iget-object v1, p1, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->av:B

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    iput-byte v0, p1, Lchat/ola/vn/w/bk;->av:B

    goto :goto_1

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :goto_1
    const/16 v0, 0x8b

    iget-byte v1, p1, Lchat/ola/vn/w/bk;->av:B

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz v0, :cond_2

    const/16 v0, 0xff

    iget-short v1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v1, v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_2
    const/16 v0, 0x8c

    iget-byte v1, p1, Lchat/ola/vn/w/bk;->au:B

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    sget-object v0, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    iget-byte v1, p1, Lchat/ola/vn/w/bk;->au:B

    aget-object v0, v0, v1

    invoke-interface {v0, p1, p2, p3}, Lchat/ola/vn/w/bb;->a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0x8c

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    sget-object v1, Lchat/ola/vn/w/cc;->e:[Lchat/ola/vn/w/bb;

    aget-object v0, v1, v0

    invoke-interface {v0, p1, p2, p3}, Lchat/ola/vn/w/bb;->a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V

    return-void
.end method
