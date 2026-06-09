.class final Lchat/ola/vn/i/i$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->d(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/entity/i;


# direct methods
.method constructor <init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$3;->a:Ljava/util/List;

    iput-object p2, p0, Lchat/ola/vn/i/i$3;->b:Landroid/content/Context;

    iput-object p3, p0, Lchat/ola/vn/i/i$3;->c:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/i/i$3;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/i/i$3;->b:Landroid/content/Context;

    const p3, 0x7f0f069d

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/i/i$3;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/i/i$3$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/i/i$3$1;-><init>(Lchat/ola/vn/i/i$3;)V

    invoke-static {p3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p3

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/network/OlaNetworkService;->n(Ljava/lang/String;S)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/i/i$3;->b:Landroid/content/Context;

    const p3, 0x7f0f042e

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/i/i$3;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->v(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/i/i$3;->b:Landroid/content/Context;

    const p2, 0x7f0f032f

    invoke-static {p1, p2}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
