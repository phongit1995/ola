.class public Lchat/ola/vn/e/i;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entity/i;",
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
.method public a(Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/i;)I
    .locals 5

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->c()J

    move-result-wide v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->c()J

    move-result-wide v2

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->c()J

    move-result-wide v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->c()J

    move-result-wide p1

    cmp-long v2, v0, p1

    if-gez v2, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/i;

    check-cast p2, Lchat/ola/vn/entity/i;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/i;->a(Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/i;)I

    move-result p1

    return p1
.end method
