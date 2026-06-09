.class Lchat/ola/vn/g/m$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/g/m;->a(Landroid/content/Context;Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/g/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/g/m;Ljava/util/List;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/m$2;->c:Lchat/ola/vn/g/m;

    iput-object p2, p0, Lchat/ola/vn/g/m$2;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

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
    iget-object p1, p0, Lchat/ola/vn/g/m$2;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    const p3, 0x7f0f045d

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    const p3, 0x7f0f0444

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    const p3, 0x7f0f0445

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    const p3, 0x7f0f054e

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/g/m$2;->c:Lchat/ola/vn/g/m;

    const/4 p2, 0x0

    :goto_0
    invoke-static {p1, p2}, Lchat/ola/vn/g/m;->a(Lchat/ola/vn/g/m;Z)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/g/m$2;->b:Landroid/content/Context;

    const p3, 0x7f0f054f

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/g/m$2;->c:Lchat/ola/vn/g/m;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p2, 0x1

    goto :goto_0

    :catch_0
    :cond_4
    return-void
.end method
