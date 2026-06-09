.class Lchat/ola/vn/m/y$10;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->h_()Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/m/y;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    iput-object p2, p0, Lchat/ola/vn/m/y$10;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/m/y$10;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    const p3, 0x7f0f04fa

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->v()V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    const p3, 0x7f0f040c

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->f()Lchat/ola/vn/m/j;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    iget-object p2, p2, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/j;->b(Lchat/ola/vn/entity/t;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    iget-object p1, p1, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    const-string p2, "null"

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    invoke-virtual {p2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "rss://"

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    const p3, 0x7f0f0623

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/y$10;->b:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->b(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
