.class Lchat/ola/vn/i/i$3$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i$3;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/i/i$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/i$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$3$1;->a:Lchat/ola/vn/i/i$3;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x2b

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/String;

    const/4 v1, 0x1

    aget-object v1, p1, v1

    check-cast v1, Lchat/ola/vn/entity/i;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, 0x0

    const/4 v3, 0x2

    :try_start_1
    aget-object p1, p1, v3

    check-cast p1, Lchat/ola/vn/entity/l;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-object p1, v2

    :goto_0
    :try_start_2
    new-instance v2, Lchat/ola/vn/i/k;

    iget-object v3, p0, Lchat/ola/vn/i/i$3$1;->a:Lchat/ola/vn/i/i$3;

    iget-object v3, v3, Lchat/ola/vn/i/i$3;->b:Landroid/content/Context;

    invoke-direct {v2, v3}, Lchat/ola/vn/i/k;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->e()C

    move-result v3

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->g()Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v2, v0, v3, p1, v1}, Lchat/ola/vn/i/k;->a(Ljava/lang/String;CLchat/ola/vn/entity/l;Ljava/lang/Long;)V

    invoke-virtual {v2}, Lchat/ola/vn/i/k;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
