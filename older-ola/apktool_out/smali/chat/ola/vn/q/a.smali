.class public Lchat/ola/vn/q/a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Lcom/mg/ola/common/widget/OlaTextView$b;


# static fields
.field private static a:Lchat/ola/vn/q/a;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lchat/ola/vn/q/a;
    .locals 1

    sget-object v0, Lchat/ola/vn/q/a;->a:Lchat/ola/vn/q/a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/q/a;

    invoke-direct {v0}, Lchat/ola/vn/q/a;-><init>()V

    sput-object v0, Lchat/ola/vn/q/a;->a:Lchat/ola/vn/q/a;

    :cond_0
    sget-object v0, Lchat/ola/vn/q/a;->a:Lchat/ola/vn/q/a;

    return-object v0
.end method

.method private a(Lchat/ola/vn/message/d;ILandroid/view/View;)V
    .locals 5

    if-eqz p1, :cond_5

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->g()V

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->x()Z

    move-result v0

    if-eqz v0, :cond_5

    move-object v0, p1

    check-cast v0, Lchat/ola/vn/message/p;

    invoke-virtual {v0}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/ab;

    iget-byte v0, p2, Lchat/ola/vn/entity/ab;->b:B

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v0, :cond_4

    iget-object p2, p2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/entity/i;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->e(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1, p2}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :pswitch_2
    :try_start_1
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->f()Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->G()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    sub-int/2addr v0, v2

    :goto_0
    if-ltz v0, :cond_1

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_1

    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_1
    :goto_1
    if-gez v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    new-array v0, v2, [Ljava/lang/String;

    aput-object p2, v0, v3

    :goto_2
    invoke-static {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a([Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p1, p3, v1, v3, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_2
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v4

    invoke-static {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-static {v4, p3, v1, v0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    new-array v0, v2, [Ljava/lang/String;

    aput-object p2, v0, v3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    :try_start_2
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    new-array v0, v2, [Ljava/lang/String;

    aput-object p2, v0, v3

    invoke-static {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a([Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p2

    invoke-static {p1, p3, v1, v3, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_4
    iget-object p1, p2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/o;->d(Ljava/lang/String;)S

    move-result p2

    packed-switch p2, :pswitch_data_1

    return-void

    :pswitch_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    new-instance p3, Ljava/io/File;

    invoke-direct {p3, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {p3}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;Landroid/net/Uri;)V

    return-void

    :pswitch_4
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-static {p2, p1, v3}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;I)V

    return-void

    :pswitch_5
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    const/4 v0, 0x2

    new-array v4, v2, [Ljava/lang/String;

    aput-object p1, v4, v3

    invoke-static {v0, v2, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(IS[Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-static {p2, p3, v1, v3, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_5
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public a(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V
    .locals 1

    :try_start_0
    invoke-interface {p3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    sget-object p2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, p2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p2

    const/4 p3, 0x0

    invoke-virtual {p2, p3}, Ljava/lang/String;->charAt(I)C

    move-result p2

    const/16 v0, 0x23

    if-eq p2, v0, :cond_3

    const/16 v0, 0x40

    if-eq p2, v0, :cond_2

    const/16 v0, 0x68

    if-eq p2, v0, :cond_1

    const/16 v0, 0x72

    if-eq p2, v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0, p3}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->o(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-static {p2, p3, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)Z
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0491

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/q/a$1;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/q/a$1;-><init>(Lchat/ola/vn/q/a;Ljava/util/List;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    const/4 p1, 0x1

    return p1
.end method

.method public b(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V
    .locals 0

    :try_start_0
    invoke-interface {p3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/q/a;->a(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09015a

    if-eq v0, v1, :cond_2

    const v1, 0x7f090355

    if-eq v0, v1, :cond_1

    const v1, 0x7f090468

    if-eq v0, v1, :cond_0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    const/4 v1, 0x4

    :goto_0
    invoke-direct {p0, v0, v1, p1}, Lchat/ola/vn/q/a;->a(Lchat/ola/vn/message/d;ILandroid/view/View;)V

    return-void

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    const/4 v1, 0x3

    goto :goto_0

    :pswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    const/4 v1, 0x2

    goto :goto_0

    :pswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    const/4 v1, 0x1

    goto :goto_0

    :pswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    invoke-static {v0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x0

    invoke-static {v0, v1, p1, v2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_2
    :try_start_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->g()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->y()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/i;

    invoke-virtual {p1}, Lchat/ola/vn/message/i;->g()V

    invoke-virtual {p1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    :goto_1
    invoke-static {v0, p1}, Lchat/ola/vn/util/b;->o(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/i;->B()Ljava/lang/String;

    move-result-object p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f090348
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
