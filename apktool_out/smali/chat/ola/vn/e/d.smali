.class public Lchat/ola/vn/e/d;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entity/t;",
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
.method public a(Lchat/ola/vn/entity/t;Lchat/ola/vn/entity/t;)I
    .locals 4

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->A()J

    move-result-wide p1

    sub-long v2, v0, p1

    long-to-int p1, v2

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/t;

    check-cast p2, Lchat/ola/vn/entity/t;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/d;->a(Lchat/ola/vn/entity/t;Lchat/ola/vn/entity/t;)I

    move-result p1

    return p1
.end method
