.class Lchat/ola/vn/m/h$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/h;->h_()Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/m/h;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/h;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    iput-object p2, p0, Lchat/ola/vn/m/h$4;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/m/h$4;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    const p3, 0x7f0f016d

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/ListView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p2}, Lchat/ola/vn/m/h;->e(Lchat/ola/vn/m/h;)Landroid/view/animation/Animation;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->f(Lchat/ola/vn/m/h;)Landroid/widget/ImageView;

    move-result-object p1

    const p2, 0x7f080637

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    const p3, 0x7f0f016c

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/ListView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->d(Lchat/ola/vn/m/h;)Landroid/widget/ListView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p2}, Lchat/ola/vn/m/h;->g(Lchat/ola/vn/m/h;)Landroid/view/animation/Animation;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->f(Lchat/ola/vn/m/h;)Landroid/widget/ImageView;

    move-result-object p1

    const p2, 0x7f080638

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    const p3, 0x7f0f016e

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;

    move-result-object p1

    const/4 p2, 0x4

    :goto_1
    invoke-virtual {p1, p2}, Lcom/google/android/gms/maps/GoogleMap;->setMapType(I)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    const p3, 0x7f0f016b

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Lchat/ola/vn/m/h;)Lcom/google/android/gms/maps/GoogleMap;

    move-result-object p1

    const/4 p2, 0x1

    goto :goto_1

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    const p3, 0x7f0f016a

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/h;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/m/h$4;->b:Lchat/ola/vn/m/h;

    invoke-virtual {p1}, Lchat/ola/vn/m/h;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method
