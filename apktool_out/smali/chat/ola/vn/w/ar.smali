.class public Lchat/ola/vn/w/ar;
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
    .locals 4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    if-eqz p3, :cond_2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->E:[Ljava/lang/String;

    array-length v0, p3

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_2

    aget-object v2, p3, v1

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    const/16 v3, 0x6e

    invoke-virtual {p2, v3, v2}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_3

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 9

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/16 v1, 0x6d

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x6e

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->c(S)I

    move-result v3

    if-lez v3, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {p1, v2, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    :goto_0
    if-ge p3, v3, :cond_1

    invoke-virtual {p1, v2, v5}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v6

    invoke-virtual {p1, v5}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v7

    const/16 v8, 0x17

    invoke-virtual {p1, v8, v5, v6}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v5

    invoke-virtual {p1, v5}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object v5

    new-instance v8, Lchat/ola/vn/entity/aa;

    invoke-direct {v8}, Lchat/ola/vn/entity/aa;-><init>()V

    iput-object v7, v8, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    iput-object v5, v8, Lchat/ola/vn/entity/aa;->b:[B

    invoke-interface {v4, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    move v5, v6

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    :cond_1
    invoke-interface {p2, v1, v4, v0}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Ljava/util/List;S)V

    return-void
.end method
