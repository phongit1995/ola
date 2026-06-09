.class Lchat/ola/vn/w/aw;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 5

    const/16 p3, 0x53

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    const-string p3, "|"

    invoke-static {p1, p3}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    new-instance p3, Ljava/util/ArrayList;

    array-length v0, p1

    div-int/lit8 v0, v0, 0x2

    invoke-direct {p3, v0}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v0, 0x0

    array-length v1, p1

    div-int/lit8 v1, v1, 0x2

    :goto_0
    if-ge v0, v1, :cond_1

    mul-int/lit8 v2, v0, 0x2

    :try_start_0
    aget-object v3, p1, v2

    const-string v4, "#sh"

    invoke-static {v4, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    :cond_0
    new-instance v4, Lchat/ola/vn/entity/af;

    add-int/lit8 v2, v2, 0x1

    aget-object v2, p1, v2

    invoke-direct {v4, v2, v3}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {p3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {p2, p3}, Lchat/ola/vn/p/g;->c(Ljava/util/List;)V

    :cond_2
    return-void
.end method
