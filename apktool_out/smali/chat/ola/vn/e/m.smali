.class public Lchat/ola/vn/e/m;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/x/c;",
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
.method public a(Lchat/ola/vn/x/c;Lchat/ola/vn/x/c;)I
    .locals 2

    iget-byte v0, p1, Lchat/ola/vn/x/c;->f:B

    iget-byte v1, p2, Lchat/ola/vn/x/c;->f:B

    if-ne v0, v1, :cond_0

    iget-short p2, p2, Lchat/ola/vn/x/c;->e:S

    iget-short p1, p1, Lchat/ola/vn/x/c;->e:S

    :goto_0
    sub-int/2addr p2, p1

    return p2

    :cond_0
    iget-byte p2, p2, Lchat/ola/vn/x/c;->f:B

    iget-byte p1, p1, Lchat/ola/vn/x/c;->f:B

    goto :goto_0
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/x/c;

    check-cast p2, Lchat/ola/vn/x/c;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/m;->a(Lchat/ola/vn/x/c;Lchat/ola/vn/x/c;)I

    move-result p1

    return p1
.end method
