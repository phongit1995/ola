.class Lchat/ola/vn/m/y$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/y;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/y;


# direct methods
.method private constructor <init>(Lchat/ola/vn/m/y;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/m/y;Lchat/ola/vn/m/y$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/y$a;-><init>(Lchat/ola/vn/m/y;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    :goto_0
    invoke-static {v0, p1}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-static {p1}, Lchat/ola/vn/m/y;->e(Lchat/ola/vn/m/y;)V

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->v()S

    move-result v3

    if-ne v3, v2, :cond_1

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result v3

    if-nez v3, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->b(S)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v3

    sub-int/2addr v3, v2

    invoke-static {v3, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->b(I)V

    goto :goto_1

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    invoke-virtual {v1, v3, v4, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result v1

    if-nez v1, :cond_2

    return-void

    :cond_2
    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/t;->b(S)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v1

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->b(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-static {v0}, Lchat/ola/vn/m/y;->d(Lchat/ola/vn/m/y;)Landroid/view/animation/Animation;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-static {p1}, Lchat/ola/vn/m/y;->c(Lchat/ola/vn/m/y;)Lchat/ola/vn/b/ah;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_3

    return-void

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-static {v1, p1, v0}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/m/y;Landroid/view/View;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f062b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nrss://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0f00a2

    const v1, 0x7f0f035c

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :sswitch_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ad;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->o()Ljava/lang/String;

    move-result-object p1

    goto/16 :goto_0

    :sswitch_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x4

    :goto_2
    invoke-static {v1, p1, v2, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x3

    goto :goto_2

    :sswitch_8
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x2

    goto :goto_2

    :sswitch_9
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    goto :goto_2

    :sswitch_a
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v2, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-static {v2, p1, v1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_b
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_4

    return-void

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :sswitch_c
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/c;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_3
    invoke-static {v1, v0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V

    return-void

    :sswitch_d
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/c;

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->j()Ljava/util/ArrayList;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->indexOf(Ljava/lang/Object;)I

    move-result v0

    invoke-static {v1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v2, p1, v3, v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :sswitch_e
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v2, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_c

    iget-byte v2, v0, Lchat/ola/vn/entry/b;->l:B

    packed-switch v2, :pswitch_data_0

    iget-object v2, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    goto :goto_5

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    :goto_4
    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :goto_5
    invoke-virtual {v2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p1

    invoke-static {v2, v0, v1, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;II)V

    return-void

    :sswitch_f
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_5

    return-void

    :cond_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    if-eqz v3, :cond_c

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_c

    iget-object v3, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v3, v2, :cond_6

    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_4

    :cond_6
    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :goto_6
    invoke-static {v1, p1, v0}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/m/y;Landroid/view/View;Ljava/util/List;)V

    return-void

    :sswitch_10
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v3, :cond_c

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_c

    iget-object v3, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ne v3, v2, :cond_8

    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_8
    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    goto :goto_6

    :sswitch_11
    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    iget-object v0, v0, Lchat/ola/vn/m/y;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;J)V

    return-void

    :sswitch_12
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->s()I

    move-result v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v2

    :goto_7
    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/me/OlaMeLikerListActivity;->a(Landroid/content/Context;IJ)V

    return-void

    :sswitch_13
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->f()I

    move-result v1

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    goto :goto_7

    :sswitch_14
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_9

    return-void

    :cond_9
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-static {v0, p1}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/m/y;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_15
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_a

    return-void

    :cond_a
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/m/y;->a(Lchat/ola/vn/m/y;Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_16
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    return-void

    :sswitch_17
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/k;

    iget-object v1, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_b

    iget-object v1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    goto/16 :goto_3

    :cond_b
    iget-object p1, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_c

    iget-object p1, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {p1}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v1, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1, v1}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    const-string v1, "wap"

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_18
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/k;

    iget-object v0, p1, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, p0, Lchat/ola/vn/m/y$a;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p1, p1, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    const-string v1, "wap"

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_c
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090048 -> :sswitch_18
        0x7f09004d -> :sswitch_18
        0x7f090052 -> :sswitch_17
        0x7f0900df -> :sswitch_16
        0x7f0900f4 -> :sswitch_15
        0x7f0900f5 -> :sswitch_14
        0x7f0900f7 -> :sswitch_13
        0x7f0900ff -> :sswitch_12
        0x7f090100 -> :sswitch_11
        0x7f090292 -> :sswitch_10
        0x7f090293 -> :sswitch_f
        0x7f090295 -> :sswitch_e
        0x7f09029e -> :sswitch_d
        0x7f09029f -> :sswitch_c
        0x7f090307 -> :sswitch_e
        0x7f09033a -> :sswitch_b
        0x7f090348 -> :sswitch_a
        0x7f090349 -> :sswitch_9
        0x7f09034a -> :sswitch_8
        0x7f09034b -> :sswitch_7
        0x7f09034c -> :sswitch_6
        0x7f090413 -> :sswitch_5
        0x7f090414 -> :sswitch_5
        0x7f090415 -> :sswitch_5
        0x7f09046c -> :sswitch_4
        0x7f09054e -> :sswitch_3
        0x7f090550 -> :sswitch_b
        0x7f09056b -> :sswitch_2
        0x7f090588 -> :sswitch_1
        0x7f0905e7 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
