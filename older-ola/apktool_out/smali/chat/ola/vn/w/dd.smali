.class public Lchat/ola/vn/w/dd;
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
    .locals 0

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 6

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/4 v1, 0x5

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x1d

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x8

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const-string v3, ";"

    invoke-static {p1, v3}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    array-length v3, p1

    if-lez v3, :cond_1

    array-length v3, p1

    rem-int/lit8 v3, v3, 0x2

    if-nez v3, :cond_1

    new-instance v3, Ljava/util/ArrayList;

    array-length v4, p1

    div-int/lit8 v4, v4, 0x2

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(I)V

    :goto_0
    array-length v4, p1

    if-ge p3, v4, :cond_0

    new-instance v4, Lchat/ola/vn/entity/ac;

    invoke-direct {v4}, Lchat/ola/vn/entity/ac;-><init>()V

    aget-object v5, p1, p3

    iput-object v5, v4, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    add-int/lit8 v5, p3, 0x1

    aget-object v5, p1, v5

    iput-object v5, v4, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x2

    goto :goto_0

    :cond_0
    invoke-interface {p2, v2, v1, v3, v0}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V

    :cond_1
    return-void
.end method
