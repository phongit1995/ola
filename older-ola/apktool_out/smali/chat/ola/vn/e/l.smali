.class public Lchat/ola/vn/e/l;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entity/x;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/x;Lchat/ola/vn/entity/x;)I
    .locals 2

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    :cond_0
    iget-object p1, p2, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object p1, p2, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    :cond_1
    invoke-virtual {v0, p1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/x;

    check-cast p2, Lchat/ola/vn/entity/x;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/l;->a(Lchat/ola/vn/entity/x;Lchat/ola/vn/entity/x;)I

    move-result p1

    return p1
.end method
