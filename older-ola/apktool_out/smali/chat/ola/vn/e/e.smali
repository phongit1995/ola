.class public Lchat/ola/vn/e/e;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/balloon/e;",
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
.method public a(Lchat/ola/vn/balloon/e;Lchat/ola/vn/balloon/e;)I
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object p1, p1, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v1

    iget-object p1, p2, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->a()J

    move-result-wide p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v3, v1, p1

    if-lez v3, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    cmp-long v3, v1, p1

    if-gez v3, :cond_1

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_1
    return v0
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/balloon/e;

    check-cast p2, Lchat/ola/vn/balloon/e;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/e;->a(Lchat/ola/vn/balloon/e;Lchat/ola/vn/balloon/e;)I

    move-result p1

    return p1
.end method
