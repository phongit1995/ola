.class public Lchat/ola/vn/w/br;
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

    sget-object v0, Lchat/ola/vn/w/br;->e:[Lchat/ola/vn/w/bb;

    if-nez v0, :cond_0

    const/16 v0, 0xa

    new-array v0, v0, [Lchat/ola/vn/w/bb;

    sput-object v0, Lchat/ola/vn/w/br;->e:[Lchat/ola/vn/w/bb;

    sget-object v0, Lchat/ola/vn/w/br;->e:[Lchat/ola/vn/w/bb;

    const/4 v1, 0x4

    new-instance v2, Lchat/ola/vn/w/cf;

    invoke-direct {v2}, Lchat/ola/vn/w/cf;-><init>()V

    aput-object v2, v0, v1

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 2

    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz v0, :cond_0

    const/16 v0, 0xff

    iget-short v1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v1, v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    const/16 v0, 0x8c

    iget-byte v1, p1, Lchat/ola/vn/w/bk;->au:B

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    sget-object v0, Lchat/ola/vn/w/br;->e:[Lchat/ola/vn/w/bb;

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

    sget-object v1, Lchat/ola/vn/w/br;->e:[Lchat/ola/vn/w/bb;

    aget-object v0, v1, v0

    invoke-interface {v0, p1, p2, p3}, Lchat/ola/vn/w/bb;->a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V

    return-void
.end method
