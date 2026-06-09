.class public Lchat/ola/vn/e/j;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entry/h;",
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
.method public a(Lchat/ola/vn/entry/h;Lchat/ola/vn/entry/h;)I
    .locals 5

    iget-wide v0, p1, Lchat/ola/vn/entry/h;->a:J

    iget-wide v2, p2, Lchat/ola/vn/entry/h;->a:J

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    iget-wide v0, p1, Lchat/ola/vn/entry/h;->a:J

    iget-wide p1, p2, Lchat/ola/vn/entry/h;->a:J

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

    check-cast p1, Lchat/ola/vn/entry/h;

    check-cast p2, Lchat/ola/vn/entry/h;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/j;->a(Lchat/ola/vn/entry/h;Lchat/ola/vn/entry/h;)I

    move-result p1

    return p1
.end method
