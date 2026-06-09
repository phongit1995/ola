.class Lchat/ola/vn/m/v$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/v;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/v;


# direct methods
.method private constructor <init>(Lchat/ola/vn/m/v;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/m/v;Lchat/ola/vn/m/v$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/v$a;-><init>(Lchat/ola/vn/m/v;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-static {v1, p1, v0}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/m/v;Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x4

    :goto_0
    invoke-static {v1, p1, v2, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x3

    goto :goto_0

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x2

    goto :goto_0

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    goto :goto_0

    :sswitch_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v2, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v2}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2, p1, v1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :sswitch_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_8

    iget-byte v1, v0, Lchat/ola/vn/entry/b;->l:B

    packed-switch v1, :pswitch_data_0

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    goto :goto_2

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    :goto_1
    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :goto_2
    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v1, v0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V

    return-void

    :sswitch_8
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    if-eqz v3, :cond_8

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_8

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v3, v2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :goto_3
    invoke-static {v1, p1, v0}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/m/v;Landroid/view/View;Ljava/util/List;)V

    return-void

    :sswitch_9
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_4

    return-void

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v3, :cond_8

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_8

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v3, v2, :cond_5

    iget-object p1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    goto :goto_3

    :sswitch_a
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v0}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->f()I

    move-result v1

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/me/OlaMeLikerListActivity;->a(Landroid/content/Context;IJ)V

    return-void

    :sswitch_b
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_6

    return-void

    :cond_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-static {v0, p1}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/m/v;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_c
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    iget-object v1, p0, Lchat/ola/vn/m/v$a;->a:Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Lchat/ola/vn/m/v;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/m/v;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_8
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0900f4 -> :sswitch_c
        0x7f0900f5 -> :sswitch_b
        0x7f0900f7 -> :sswitch_a
        0x7f090292 -> :sswitch_9
        0x7f090293 -> :sswitch_8
        0x7f090295 -> :sswitch_7
        0x7f090307 -> :sswitch_7
        0x7f09033a -> :sswitch_6
        0x7f090348 -> :sswitch_5
        0x7f090349 -> :sswitch_4
        0x7f09034a -> :sswitch_3
        0x7f09034b -> :sswitch_2
        0x7f09034c -> :sswitch_1
        0x7f09054e -> :sswitch_0
        0x7f090550 -> :sswitch_6
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
