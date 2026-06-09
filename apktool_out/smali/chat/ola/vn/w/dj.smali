.class public Lchat/ola/vn/w/dj;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 5

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x6e

    const/4 v1, 0x0

    if-eqz p3, :cond_2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->a:[Lchat/ola/vn/entity/aa;

    if-eqz p3, :cond_4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->a:[Lchat/ola/vn/entity/aa;

    array-length v2, p3

    :goto_0
    if-ge v1, v2, :cond_4

    aget-object v3, p3, v1

    iget-object v4, v3, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, v3, Lchat/ola/vn/entity/aa;->b:[B

    if-eqz v4, :cond_1

    iget-object v4, v3, Lchat/ola/vn/entity/aa;->b:[B

    array-length v4, v4

    if-lez v4, :cond_1

    iget-object v4, v3, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    invoke-virtual {p2, v0, v4}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v4, 0x17

    iget-object v3, v3, Lchat/ola/vn/entity/aa;->b:[B

    invoke-virtual {p2, v4, v3}, Lchat/ola/vn/w/cg;->a(S[B)V

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->a:[Lchat/ola/vn/entity/aa;

    if-eqz p3, :cond_4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->a:[Lchat/ola/vn/entity/aa;

    array-length v2, p3

    :goto_1
    if-ge v1, v2, :cond_4

    aget-object v3, p3, v1

    iget-object v4, v3, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    iget-object v3, v3, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    invoke-virtual {p2, v0, v3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_4
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_5

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_5
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 0

    return-void
.end method
