.class public Lchat/ola/vn/i/i;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;II)Landroid/app/Dialog;
    .locals 0

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    .locals 7

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v2, p1

    goto :goto_0

    :cond_0
    move-object v2, v0

    :goto_0
    if-eqz p2, :cond_1

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v3, p1

    goto :goto_1

    :cond_1
    move-object v3, v0

    :goto_1
    if-eqz p3, :cond_2

    invoke-virtual {p0, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v4, p1

    goto :goto_2

    :cond_2
    move-object v4, v0

    :goto_2
    if-eqz p4, :cond_3

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    move-object v5, v0

    move-object v1, p0

    move-object v6, p5

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;Landroid/graphics/Bitmap;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    .locals 1

    new-instance v0, Lchat/ola/vn/i/e;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/e;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/e;->setTitle(Ljava/lang/CharSequence;)V

    if-eqz p1, :cond_0

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/e;->a(Landroid/graphics/Bitmap;)V

    :cond_0
    invoke-virtual {v0, p3}, Lchat/ola/vn/i/e;->a(Ljava/lang/CharSequence;)V

    const p0, 0x7f0f0480

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/e;->a(I)V

    new-instance p0, Lchat/ola/vn/i/i$8;

    invoke-direct {p0}, Lchat/ola/vn/i/i$8;-><init>()V

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/e;->a(Landroid/content/DialogInterface$OnClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/e;->show()V

    return-object v0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    .locals 0

    invoke-static/range {p0 .. p5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;IILjava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;
    .locals 6

    const/4 v5, 0x1

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IILjava/lang/CharSequence;Ljava/lang/CharSequence;I)Landroid/app/ProgressDialog;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;IILjava/lang/CharSequence;Ljava/lang/CharSequence;I)Landroid/app/ProgressDialog;
    .locals 1

    new-instance v0, Landroid/app/ProgressDialog;

    invoke-direct {v0, p0}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p3}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p4}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p5}, Landroid/app/ProgressDialog;->setProgressStyle(I)V

    invoke-virtual {v0, p1}, Landroid/app/ProgressDialog;->setProgress(I)V

    invoke-virtual {v0, p2}, Landroid/app/ProgressDialog;->setMax(I)V

    return-object v0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;I)Landroid/app/ProgressDialog;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;I)Landroid/app/ProgressDialog;
    .locals 1

    new-instance v0, Landroid/app/ProgressDialog;

    invoke-direct {v0, p0}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p2}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, p3}, Landroid/app/ProgressDialog;->setProgressStyle(I)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Landroid/app/ProgressDialog;->setIndeterminate(Z)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Landroid/app/ProgressDialog;->setProgress(I)V

    invoke-virtual {v0, p0}, Landroid/app/ProgressDialog;->setMax(I)V

    invoke-virtual {v0, p0}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    invoke-virtual {v0, p0}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    return-object v0
.end method

.method public static a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;
    .locals 1

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/c;->setCancelable(Z)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/c;->a(I)V

    invoke-virtual {v0, p2, p3, p4}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    return-object v0
.end method

.method public static a(Landroid/content/Context;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "IIIIII",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/content/DialogInterface$OnClickListener;",
            ")",
            "Lchat/ola/vn/i/p;"
        }
    .end annotation

    const/4 v1, 0x0

    const/4 v10, 0x0

    move-object v0, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move-object/from16 v8, p7

    move-object/from16 v9, p8

    invoke-static/range {v0 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object v0

    return-object v0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)Lchat/ola/vn/i/p;
    .locals 11

    new-instance v9, Lchat/ola/vn/i/i$1;

    invoke-direct {v9, p1, p0}, Lchat/ola/vn/i/i$1;-><init>(Ljava/lang/String;Landroid/content/Context;)V

    const/4 v1, 0x0

    const v2, 0x7f0806ac

    const v3, 0x7f0f05eb

    const v4, 0x7f0f0665

    const v5, 0x7f0f0612

    const v6, 0x7f0f0480

    const/16 v7, 0x4000

    const/4 v8, 0x0

    const/4 v10, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "IIIIII",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/content/DialogInterface$OnClickListener;",
            "Lchat/ola/vn/i/p$a;",
            ")",
            "Lchat/ola/vn/i/p;"
        }
    .end annotation

    if-nez p8, :cond_0

    new-instance p8, Lchat/ola/vn/i/p;

    invoke-direct {p8, p0}, Lchat/ola/vn/i/p;-><init>(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    new-instance v0, Lchat/ola/vn/i/r;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/r;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p8}, Lchat/ola/vn/i/r;->a(Ljava/util/List;)Lchat/ola/vn/i/r;

    move-result-object p8

    :goto_0
    if-lez p2, :cond_1

    :try_start_0
    invoke-virtual {p8, p2}, Lchat/ola/vn/i/p;->a(I)V

    :cond_1
    invoke-virtual {p8, p7}, Lchat/ola/vn/i/p;->b(I)V

    if-eqz p3, :cond_2

    invoke-virtual {p0, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p8, p2}, Lchat/ola/vn/i/p;->setTitle(Ljava/lang/CharSequence;)V

    :cond_2
    invoke-virtual {p8, p1}, Lchat/ola/vn/i/p;->a(Ljava/lang/String;)V

    if-eqz p4, :cond_3

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p8, p1}, Lchat/ola/vn/i/p;->c(Ljava/lang/String;)V

    :cond_3
    if-lez p5, :cond_4

    invoke-virtual {p0, p5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p8, p1}, Lchat/ola/vn/i/p;->b(Ljava/lang/String;)V

    :cond_4
    if-lez p6, :cond_5

    invoke-virtual {p0, p6}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p8, p0}, Lchat/ola/vn/i/p;->d(Ljava/lang/String;)V

    :cond_5
    invoke-virtual {p8, p9}, Lchat/ola/vn/i/p;->a(Landroid/content/DialogInterface$OnClickListener;)V

    invoke-virtual {p8}, Lchat/ola/vn/i/p;->show()V

    invoke-virtual {p8, p10}, Lchat/ola/vn/i/p;->a(Lchat/ola/vn/i/p$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p8
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "IIIII",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/content/DialogInterface$OnClickListener;",
            ")",
            "Lchat/ola/vn/i/p;"
        }
    .end annotation

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    invoke-static/range {v0 .. v9}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object v0

    return-object v0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "IIIII",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/content/DialogInterface$OnClickListener;",
            "Lchat/ola/vn/i/p$a;",
            ")",
            "Lchat/ola/vn/i/p;"
        }
    .end annotation

    const/16 v7, 0x2000

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move-object/from16 v8, p7

    move-object/from16 v9, p8

    move-object/from16 v10, p9

    invoke-static/range {v0 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object v0

    return-object v0
.end method

.method public static a()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f00a7

    const v2, 0x7f0f03a8

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 6

    const v1, 0x7f0f009b

    const v2, 0x7f0f02b2

    const v3, 0x7f0f0522

    const v4, 0x7f0f0480

    :try_start_0
    new-instance v5, Lchat/ola/vn/i/i$9;

    invoke-direct {v5, p0}, Lchat/ola/vn/i/i$9;-><init>(Landroid/content/Context;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/e;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0628

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0691

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f06a5

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$5;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$5;-><init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04c7

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f05b2

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f056b

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$14;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$14;-><init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->a()Z

    move-result p2

    if-eqz p2, :cond_0

    const p2, 0x7f0f04c7

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    const p2, 0x7f0f0691

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p2, Lchat/ola/vn/i/m;

    invoke-direct {p2, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/i/i$6;

    invoke-direct {v1, v0, p0, p1}, Lchat/ola/vn/i/i$6;-><init>(Ljava/util/List;Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {p2, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p2}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    .locals 7

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v2, p1

    goto :goto_0

    :cond_0
    move-object v2, v0

    :goto_0
    if-eqz p2, :cond_1

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v3, p1

    goto :goto_1

    :cond_1
    move-object v3, v0

    :goto_1
    if-eqz p3, :cond_2

    invoke-virtual {p0, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v4, p1

    goto :goto_2

    :cond_2
    move-object v4, v0

    :goto_2
    if-eqz p4, :cond_3

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    move-object v5, v0

    move-object v1, p0

    move-object v6, p5

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    move-result-object p0

    return-object p0
.end method

.method public static b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Landroid/graphics/Bitmap;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object p0

    return-object p0
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    new-instance v0, Lchat/ola/vn/i/e;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/e;-><init>(Landroid/content/Context;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/e;->setCanceledOnTouchOutside(Z)V

    if-eqz p1, :cond_1

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/e;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    const p0, 0x7f0f00a2

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/e;->setTitle(I)V

    :goto_0
    if-eqz p2, :cond_2

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/e;->a(Ljava/lang/CharSequence;)V

    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/e;->a(Ljava/lang/String;)V

    :cond_3
    if-eqz p4, :cond_4

    invoke-virtual {v0, p4}, Lchat/ola/vn/i/e;->b(Ljava/lang/String;)V

    :cond_4
    if-eqz p5, :cond_5

    invoke-virtual {v0, p5}, Lchat/ola/vn/i/e;->a(Landroid/content/DialogInterface$OnClickListener;)V

    :cond_5
    invoke-virtual {v0}, Lchat/ola/vn/i/e;->show()V

    return-object v0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 4

    const v0, 0x7f0f0193

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "1900588883"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const v2, 0x7f0f0194

    invoke-virtual {p0, v2, v1}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void
.end method

.method public static b(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f069d

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042e

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$15;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$15;-><init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    const v0, 0x7f0f0191

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const p1, 0x7f0f0192

    invoke-virtual {p0, p1, v1}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void
.end method

.method public static c(Landroid/content/Context;)Landroid/app/Dialog;
    .locals 6

    new-instance v5, Lchat/ola/vn/i/i$12;

    invoke-direct {v5, p0}, Lchat/ola/vn/i/i$12;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f00a2

    const v2, 0x7f0f032e

    const v3, 0x7f0f0444

    const v4, 0x7f0f0480

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    move-result-object p0

    return-object p0
.end method

.method public static c(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    .locals 7

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v2, p1

    goto :goto_0

    :cond_0
    move-object v2, v0

    :goto_0
    if-eqz p2, :cond_1

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v3, p1

    goto :goto_1

    :cond_1
    move-object v3, v0

    :goto_1
    if-eqz p3, :cond_2

    invoke-virtual {p0, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v4, p1

    goto :goto_2

    :cond_2
    move-object v4, v0

    :goto_2
    if-eqz p4, :cond_3

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    move-object v5, v0

    move-object v1, p0

    move-object v6, p5

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/d;

    move-result-object p0

    return-object p0
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/d;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    new-instance v0, Lchat/ola/vn/i/d;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/d;-><init>(Landroid/content/Context;)V

    if-eqz p1, :cond_1

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/d;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    const p0, 0x7f0f00a2

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/d;->setTitle(I)V

    :goto_0
    if-eqz p2, :cond_2

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/d;->a(Ljava/lang/CharSequence;)V

    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/d;->a(Ljava/lang/String;)V

    :cond_3
    if-eqz p4, :cond_4

    invoke-virtual {v0, p4}, Lchat/ola/vn/i/d;->b(Ljava/lang/String;)V

    :cond_4
    if-eqz p5, :cond_5

    invoke-virtual {v0, p5}, Lchat/ola/vn/i/d;->a(Landroid/content/DialogInterface$OnClickListener;)V

    :cond_5
    invoke-virtual {v0}, Lchat/ola/vn/i/d;->show()V

    return-object v0
.end method

.method public static c(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04c7

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f05b2

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f056b

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$2;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$2;-><init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 7

    const v0, 0x7f0f0191

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    const v1, 0x7f0f02e1

    invoke-virtual {p0, v1, v0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f0446

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0480

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/i/i$10;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/i/i$10;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method public static d(Landroid/content/Context;)Landroid/app/Dialog;
    .locals 7

    const v0, 0x7f0f0255

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f00a2

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v0, 0x7f0f0444

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0480

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/i/i$13;

    invoke-direct {v6, p0}, Lchat/ola/vn/i/i$13;-><init>(Landroid/content/Context;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    move-result-object p0

    return-object p0
.end method

.method public static d(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    .locals 7

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v2, p1

    goto :goto_0

    :cond_0
    move-object v2, v0

    :goto_0
    if-eqz p2, :cond_1

    invoke-virtual {p0, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v3, p1

    goto :goto_1

    :cond_1
    move-object v3, v0

    :goto_1
    if-eqz p3, :cond_2

    invoke-virtual {p0, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    move-object v4, p1

    goto :goto_2

    :cond_2
    move-object v4, v0

    :goto_2
    if-eqz p4, :cond_3

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    move-object v5, v0

    move-object v1, p0

    move-object v6, p5

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    move-result-object p0

    return-object p0
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Dialog;
    .locals 6

    new-instance v5, Lchat/ola/vn/i/i$11;

    invoke-direct {v5, p0}, Lchat/ola/vn/i/i$11;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f00a2

    const v2, 0x7f0f02cf

    const v3, 0x7f0f05c2

    const v4, 0x7f0f0480

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    move-result-object p0

    return-object p0
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    new-instance v0, Lchat/ola/vn/i/f;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/f;-><init>(Landroid/content/Context;)V

    if-eqz p1, :cond_1

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/f;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    const p0, 0x7f0f00a2

    invoke-virtual {v0, p0}, Lchat/ola/vn/i/f;->setTitle(I)V

    :goto_0
    if-eqz p2, :cond_2

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/f;->a(Ljava/lang/CharSequence;)V

    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/f;->a(Ljava/lang/String;)V

    :cond_3
    if-eqz p4, :cond_4

    invoke-virtual {v0, p4}, Lchat/ola/vn/i/f;->b(Ljava/lang/String;)V

    :cond_4
    if-eqz p5, :cond_5

    invoke-virtual {v0, p5}, Lchat/ola/vn/i/f;->a(Landroid/content/DialogInterface$OnClickListener;)V

    :cond_5
    invoke-virtual {v0}, Lchat/ola/vn/i/f;->show()V

    return-object v0
.end method

.method public static d(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f069d

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042e

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$3;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$3;-><init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static e(Landroid/content/Context;)V
    .locals 8

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f0660

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f0649

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f0623

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f044d

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lchat/ola/vn/i/i$7;

    invoke-direct {v7, p0}, Lchat/ola/vn/i/i$7;-><init>(Landroid/content/Context;)V

    move-object v2, p0

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static e(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04c7

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f05b2

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/i/i$4;

    invoke-direct {v2, v0, p0, p1}, Lchat/ola/vn/i/i$4;-><init>(Ljava/util/List;Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
