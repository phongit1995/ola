.class Lchat/ola/vn/m/j$a;
.super Lchat/ola/vn/view/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/m/c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lchat/ola/vn/m/j;Landroid/support/v4/app/FragmentManager;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0, p2}, Lchat/ola/vn/view/b;-><init>(Landroid/support/v4/app/FragmentManager;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/j$a;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/m/j$a;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    return-object p1
.end method


# virtual methods
.method public a(I)Lchat/ola/vn/m/c;
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->a(S)V

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->m()S

    move-result v0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    goto :goto_0

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    invoke-virtual {v0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/m/x;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/c;

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/c;->a(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V

    return-object v0

    :goto_0
    invoke-virtual {v0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const-class v1, Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/c;

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/c;->a(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public synthetic b(I)Landroid/support/v4/app/Fragment;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j$a;->a(I)Lchat/ola/vn/m/c;

    move-result-object p1

    return-object p1
.end method

.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 0

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/view/b;->destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V

    return-void
.end method

.method public getCount()I
    .locals 4

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/4 v0, 0x0

    return v0

    :cond_0
    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    const/4 v2, 0x0

    if-le v1, v0, :cond_1

    add-int/lit8 v1, v1, -0x1

    iget-object v3, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v3, v1, v2}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v1, v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_2
    return v0
.end method

.method public getItemPosition(Ljava/lang/Object;)I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    const/4 p1, -0x2

    return p1

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/view/b;->getItemPosition(Ljava/lang/Object;)I

    move-result p1

    return p1
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 2

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/view/b;->instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/c;

    sget-object v1, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/t;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->a:Lchat/ola/vn/m/j;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/c;->a(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/m/j$a;->b:Ljava/util/List;

    invoke-interface {v1, p2, v0}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-super {p0, p1, p2}, Lchat/ola/vn/view/b;->instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
