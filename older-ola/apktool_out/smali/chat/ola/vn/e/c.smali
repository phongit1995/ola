.class public Lchat/ola/vn/e/c;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entity/g;",
        ">;"
    }
.end annotation


# instance fields
.field private a:I


# direct methods
.method public constructor <init>()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/e/c;-><init>(Z)V

    return-void
.end method

.method public constructor <init>(Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_0

    const/4 p1, -0x1

    :goto_0
    iput p1, p0, Lchat/ola/vn/e/c;->a:I

    return-void

    :cond_0
    const/4 p1, 0x1

    goto :goto_0

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/g;Lchat/ola/vn/entity/g;)I
    .locals 5

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v2

    cmp-long v4, v0, v2

    if-gez v4, :cond_0

    iget p1, p0, Lchat/ola/vn/e/c;->a:I

    mul-int/lit8 p1, p1, -0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide p1

    cmp-long v2, v0, p1

    if-nez v2, :cond_1

    const/4 p1, 0x0

    return p1

    :cond_1
    iget p1, p0, Lchat/ola/vn/e/c;->a:I

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/g;

    check-cast p2, Lchat/ola/vn/entity/g;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/c;->a(Lchat/ola/vn/entity/g;Lchat/ola/vn/entity/g;)I

    move-result p1

    return p1
.end method
