.class public Lchat/ola/vn/e/h;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/message/f;",
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
.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/f;)I
    .locals 8

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, -0x1

    const/4 v2, 0x5

    if-ne v0, v2, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v2, :cond_0

    return v1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v3, 0x1

    if-eq v0, v2, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v2, :cond_1

    return v3

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v4

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v6

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->z()I

    move-result p1

    const/4 v0, 0x0

    if-lez p1, :cond_2

    const/4 p1, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    :goto_0
    invoke-virtual {p2}, Lchat/ola/vn/message/f;->z()I

    move-result p2

    if-lez p2, :cond_3

    const/4 p2, 0x1

    goto :goto_1

    :cond_3
    const/4 p2, 0x0

    :goto_1
    if-eqz p1, :cond_4

    if-nez p2, :cond_4

    return v1

    :cond_4
    if-nez p1, :cond_5

    if-eqz p2, :cond_5

    return v3

    :cond_5
    cmp-long p1, v4, v6

    if-lez p1, :cond_6

    return v1

    :cond_6
    cmp-long p1, v4, v6

    if-gez p1, :cond_7

    return v3

    :cond_7
    return v0
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/message/f;

    check-cast p2, Lchat/ola/vn/message/f;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/h;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/f;)I

    move-result p1

    return p1
.end method
