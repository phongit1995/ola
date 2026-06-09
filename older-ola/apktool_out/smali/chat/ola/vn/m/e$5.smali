.class Lchat/ola/vn/m/e$5;
.super Landroid/support/v4/app/FragmentPagerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/e;->b(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/e;Landroid/support/v4/app/FragmentManager;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-direct {p0, p2}, Landroid/support/v4/app/FragmentPagerAdapter;-><init>(Landroid/support/v4/app/FragmentManager;)V

    return-void
.end method


# virtual methods
.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v0}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, p2, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    invoke-super {p0, p1, p2, p3}, Landroid/support/v4/app/FragmentPagerAdapter;->destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V

    return-void
.end method

.method public getCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method public getItem(I)Landroid/support/v4/app/Fragment;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {v1}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    packed-switch p1, :pswitch_data_0

    move-object p1, v0

    goto :goto_1

    :pswitch_0
    iget-object v2, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v2}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v2}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v2

    :goto_0
    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/p;

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {p1}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v2, Lchat/ola/vn/m/n;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/n;

    goto :goto_1

    :pswitch_1
    iget-object v2, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v2}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v2}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v2

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {p1}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v2, Lchat/ola/vn/m/o;

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/o;

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {p1, v2}, Lchat/ola/vn/m/p;->a(Ljava/lang/Object;)V

    invoke-virtual {p1, v1}, Lchat/ola/vn/m/p;->setArguments(Landroid/os/Bundle;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v0, p2}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;I)Lchat/ola/vn/m/p;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/p;->a(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-virtual {v1}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/p;->setArguments(Landroid/os/Bundle;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/m/e$5;->a:Lchat/ola/vn/m/e;

    invoke-static {v1}, Lchat/ola/vn/m/e;->d(Lchat/ola/vn/m/e;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, p2, v0}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    invoke-super {p0, p1, p2}, Landroid/support/v4/app/FragmentPagerAdapter;->instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
