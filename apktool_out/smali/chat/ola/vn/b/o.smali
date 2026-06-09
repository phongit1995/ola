.class public Lchat/ola/vn/b/o;
.super Landroid/widget/BaseAdapter;


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Landroid/view/View$OnClickListener;

.field private c:Landroid/view/View$OnLongClickListener;

.field private d:Landroid/content/Context;

.field private e:Lchat/ola/vn/message/f;

.field private f:Landroid/view/animation/Animation;

.field private g:Landroid/view/animation/Animation;

.field private h:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/message/f;)V
    .locals 1

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Lchat/ola/vn/b/o;->a:Landroid/view/LayoutInflater;

    iput-object p1, p0, Lchat/ola/vn/b/o;->d:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/b/o;->e:Lchat/ola/vn/message/f;

    return-void
.end method


# virtual methods
.method public a(I)Lchat/ola/vn/message/d;
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/o;->e:Lchat/ola/vn/message/f;

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/b/o;->e:Lchat/ola/vn/message/f;

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/f;->b(I)Lchat/ola/vn/message/d;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object v0
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/o;->b:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/o;->c:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/o;->e:Lchat/ola/vn/message/f;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/o;->e:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->K()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    mul-int/lit8 p1, p1, 0x13

    add-int/2addr v0, p1

    return v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 17

    move-object/from16 v1, p0

    :try_start_0
    invoke-virtual/range {p0 .. p1}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object v3

    if-nez p2, :cond_0

    iget-object v5, v1, Lchat/ola/vn/b/o;->a:Landroid/view/LayoutInflater;

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->e()B

    move-result v6

    int-to-short v6, v6

    invoke-static {v5, v3, v6}, Lchat/ola/vn/entry/b/c;->a(Landroid/view/LayoutInflater;Lchat/ola/vn/message/d;S)Landroid/view/View;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    move-object v4, v5

    goto :goto_0

    :cond_0
    move-object/from16 v4, p2

    :goto_0
    :try_start_1
    invoke-virtual {v4}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v5

    if-eqz v5, :cond_6

    invoke-virtual {v4}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entry/b/b;

    invoke-virtual {v5}, Lchat/ola/vn/entry/b/b;->a()V

    iget-object v6, v1, Lchat/ola/vn/b/o;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v5, v6}, Lchat/ola/vn/entry/b/b;->a(Landroid/view/View$OnClickListener;)V

    iget-object v6, v1, Lchat/ola/vn/b/o;->c:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v5, v6}, Lchat/ola/vn/entry/b/b;->a(Landroid/view/View$OnLongClickListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    add-int/lit8 v6, p1, -0x1

    const/4 v7, 0x0

    :try_start_2
    invoke-virtual {v1, v6}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object v6
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :catch_0
    move-object v6, v7

    :goto_1
    const/4 v8, 0x1

    add-int/lit8 v2, p1, 0x1

    :try_start_3
    invoke-virtual {v1, v2}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object v2
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_2

    :catch_1
    move-object v2, v7

    :goto_2
    if-eqz v3, :cond_6

    :try_start_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :try_start_5
    invoke-virtual {v3}, Lchat/ola/vn/message/d;->b()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->d()B

    move-result v7

    if-ne v7, v8, :cond_1

    const/4 v7, 0x3

    invoke-virtual {v3, v7}, Lchat/ola/vn/message/d;->b(B)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :catch_2
    :cond_1
    :try_start_6
    invoke-virtual {v5, v3, v6, v2}, Lchat/ola/vn/entry/b/b;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    sget-byte v2, Lchat/ola/vn/c/x;->l:B
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    const-wide/16 v5, 0x3e8

    const-wide/16 v11, 0x12c

    packed-switch v2, :pswitch_data_0

    goto/16 :goto_5

    :pswitch_0
    :try_start_7
    invoke-virtual {v3}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v13

    const/4 v2, 0x0

    sub-long v15, v9, v13

    cmp-long v2, v15, v5

    if-gez v2, :cond_4

    iget-boolean v2, v3, Lchat/ola/vn/message/d;->v:Z

    if-nez v2, :cond_4

    iput-boolean v8, v3, Lchat/ola/vn/message/d;->v:Z

    invoke-virtual {v3}, Lchat/ola/vn/message/d;->d()B

    move-result v2

    packed-switch v2, :pswitch_data_1

    goto/16 :goto_5

    :pswitch_1
    iget-object v2, v1, Lchat/ola/vn/b/o;->g:Landroid/view/animation/Animation;

    if-nez v2, :cond_2

    iget-object v2, v1, Lchat/ola/vn/b/o;->d:Landroid/content/Context;

    const v3, 0x7f01004d

    invoke-static {v2, v3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/b/o;->g:Landroid/view/animation/Animation;

    iget-object v2, v1, Lchat/ola/vn/b/o;->g:Landroid/view/animation/Animation;

    invoke-virtual {v2, v11, v12}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_2
    iget-object v2, v1, Lchat/ola/vn/b/o;->g:Landroid/view/animation/Animation;

    invoke-virtual {v2}, Landroid/view/animation/Animation;->cancel()V

    iget-object v2, v1, Lchat/ola/vn/b/o;->g:Landroid/view/animation/Animation;

    :goto_3
    invoke-virtual {v4, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    goto :goto_5

    :pswitch_2
    iget-object v2, v1, Lchat/ola/vn/b/o;->f:Landroid/view/animation/Animation;

    if-nez v2, :cond_3

    iget-object v2, v1, Lchat/ola/vn/b/o;->d:Landroid/content/Context;

    const v3, 0x7f01004c

    invoke-static {v2, v3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/b/o;->f:Landroid/view/animation/Animation;

    iget-object v2, v1, Lchat/ola/vn/b/o;->f:Landroid/view/animation/Animation;

    invoke-virtual {v2, v11, v12}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_3
    iget-object v2, v1, Lchat/ola/vn/b/o;->f:Landroid/view/animation/Animation;

    invoke-virtual {v2}, Landroid/view/animation/Animation;->cancel()V

    iget-object v2, v1, Lchat/ola/vn/b/o;->f:Landroid/view/animation/Animation;

    goto :goto_3

    :cond_4
    iput-boolean v8, v3, Lchat/ola/vn/message/d;->v:Z

    invoke-virtual {v4}, Landroid/view/View;->clearAnimation()V

    goto :goto_5

    :pswitch_3
    invoke-virtual {v3}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v13

    const/4 v2, 0x0

    sub-long v15, v9, v13

    cmp-long v2, v15, v5

    if-gez v2, :cond_4

    iget-boolean v2, v3, Lchat/ola/vn/message/d;->v:Z

    if-nez v2, :cond_4

    iput-boolean v8, v3, Lchat/ola/vn/message/d;->v:Z

    iget-object v2, v1, Lchat/ola/vn/b/o;->h:Landroid/view/animation/Animation;

    if-nez v2, :cond_5

    iget-object v2, v1, Lchat/ola/vn/b/o;->d:Landroid/content/Context;

    const v5, 0x7f010021

    invoke-static {v2, v5}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/b/o;->h:Landroid/view/animation/Animation;

    iget-object v2, v1, Lchat/ola/vn/b/o;->h:Landroid/view/animation/Animation;

    invoke-virtual {v2, v11, v12}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_5
    invoke-virtual {v3}, Lchat/ola/vn/message/d;->d()B

    move-result v2

    packed-switch v2, :pswitch_data_2

    goto :goto_5

    :pswitch_4
    iget-object v2, v1, Lchat/ola/vn/b/o;->h:Landroid/view/animation/Animation;

    invoke-virtual {v2}, Landroid/view/animation/Animation;->cancel()V

    iget-object v2, v1, Lchat/ola/vn/b/o;->h:Landroid/view/animation/Animation;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_3

    :pswitch_5
    :try_start_8
    iput-boolean v8, v3, Lchat/ola/vn/message/d;->v:Z
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_5

    :catch_3
    move-exception v0

    goto :goto_4

    :catch_4
    move-exception v0

    move-object/from16 v4, p2

    :goto_4
    move-object v2, v0

    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_5
    :cond_6
    :goto_5
    if-nez v4, :cond_7

    return-object p3

    :cond_7
    return-object v4

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_3
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_4
        :pswitch_4
    .end packed-switch
.end method

.method public getViewTypeCount()I
    .locals 1

    const/16 v0, 0x39

    return v0
.end method
