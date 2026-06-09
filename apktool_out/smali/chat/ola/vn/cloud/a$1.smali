.class Lchat/ola/vn/cloud/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/a;->g()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lchat/ola/vn/entity/l;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/a$1;->a:Lchat/ola/vn/cloud/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/l;Lchat/ola/vn/entity/l;)I
    .locals 1

    invoke-virtual {p1}, Lchat/ola/vn/entity/l;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/entity/l;->a()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/l;->a()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/entity/l;->a()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    iget-short p1, p1, Lchat/ola/vn/entity/l;->i:S

    iget-short p2, p2, Lchat/ola/vn/entity/l;->i:S

    sub-int/2addr p1, p2

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/l;

    check-cast p2, Lchat/ola/vn/entity/l;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/cloud/a$1;->a(Lchat/ola/vn/entity/l;Lchat/ola/vn/entity/l;)I

    move-result p1

    return p1
.end method
