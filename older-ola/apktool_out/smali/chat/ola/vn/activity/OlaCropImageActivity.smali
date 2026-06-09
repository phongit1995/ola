.class public Lchat/ola/vn/activity/OlaCropImageActivity;
.super Lchat/ola/vn/c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaCropImageActivity$a;,
        Lchat/ola/vn/activity/OlaCropImageActivity$b;
    }
.end annotation


# static fields
.field private static e:I = 0x1

.field private static f:I = 0x0

.field private static g:I = 0x0

.field private static h:Landroid/net/Uri; = null

.field private static i:Z = false

.field private static j:Lchat/ola/vn/activity/OlaCropImageActivity$b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    sput v0, Lchat/ola/vn/activity/OlaCropImageActivity;->f:I

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    sput v0, Lchat/ola/vn/activity/OlaCropImageActivity;->g:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaImageCropToolActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    sget-object v1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const-string v1, "outputX"

    sget v2, Lchat/ola/vn/activity/OlaCropImageActivity;->f:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "outputY"

    sget v2, Lchat/ola/vn/activity/OlaCropImageActivity;->g:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "aspectX"

    sget v2, Lchat/ola/vn/activity/OlaCropImageActivity;->f:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "aspectY"

    sget v2, Lchat/ola/vn/activity/OlaCropImageActivity;->g:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "scale"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "return-data"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "outputFormat"

    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {v2}, Landroid/graphics/Bitmap$CompressFormat;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 v1, 0x3

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method private static C()I
    .locals 2

    sget v0, Lchat/ola/vn/e;->c:I

    const/16 v1, 0x500

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method static synthetic a(Landroid/content/Context;Landroid/net/Uri;III)V
    .locals 0

    invoke-static {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Landroid/net/Uri;III)V

    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/entity/i;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->d(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V
    .locals 4

    :try_start_0
    sput-object p4, Lchat/ola/vn/activity/OlaCropImageActivity;->j:Lchat/ola/vn/activity/OlaCropImageActivity$b;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p4

    if-nez p4, :cond_2

    new-instance p4, Ljava/io/File;

    invoke-direct {p4, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p4}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    new-instance p1, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->m()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ".crop."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v2, ".tmp"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :cond_1
    :try_start_1
    invoke-static {p4, p1}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;Ljava/io/File;)V

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4}, Lchat/ola/vn/d;->g(Ljava/lang/String;)V

    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    sget-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    const/4 p4, 0x2

    invoke-static {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Landroid/net/Uri;III)V

    return-void

    :cond_2
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    const p4, 0x7f0f063f

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p4

    invoke-interface {p1, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p4, 0x7f0f0607

    invoke-virtual {p0, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p4

    invoke-interface {p1, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p4, Lchat/ola/vn/i/m;

    invoke-direct {p4, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    const v0, 0x7f0f060c

    invoke-virtual {p4, v0}, Lchat/ola/vn/i/m;->setTitle(I)V

    invoke-virtual {p4, p1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p1, Lchat/ola/vn/activity/OlaCropImageActivity$5;

    invoke-direct {p1, p0, p2, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$5;-><init>(Landroid/content/Context;II)V

    invoke-virtual {p4, p1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p4}, Lchat/ola/vn/i/m;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic a(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x0

    invoke-static {p0, p1, v1, v0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaCropImageActivity$13;

    invoke-direct {v0, p0, p1, p4}, Lchat/ola/vn/activity/OlaCropImageActivity$13;-><init>(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p2, p3, p3, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method public static b(Landroid/content/Context;)V
    .locals 2

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static b(Landroid/content/Context;Landroid/net/Uri;III)V
    .locals 0

    :try_start_0
    sput-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/activity/OlaCropImageActivity;->i:Z

    sput p4, Lchat/ola/vn/activity/OlaCropImageActivity;->e:I

    sput p2, Lchat/ola/vn/activity/OlaCropImageActivity;->f:I

    sput p3, Lchat/ola/vn/activity/OlaCropImageActivity;->g:I

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/activity/OlaCropImageActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static b(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->d(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method static synthetic b(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {p0, p1, v1, v0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    mul-int/lit8 v0, p3, 0x9

    div-int/lit8 v0, v0, 0x10

    new-instance v1, Lchat/ola/vn/activity/OlaCropImageActivity$2;

    invoke-direct {v1, p0, p1, p4}, Lchat/ola/vn/activity/OlaCropImageActivity$2;-><init>(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p2, p3, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method public static c(Landroid/content/Context;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static c(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static c(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 10

    new-instance v0, Lchat/ola/vn/activity/OlaCropImageActivity$1;

    invoke-direct {v0, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$1;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    const v1, 0x7f0f023d

    const-wide/32 v2, 0x2bf20

    invoke-static {p0, v1, v2, v3, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p1, p2, v1}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;IZ)Lchat/ola/vn/c/f;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/activity/OlaCropImageActivity$6;

    move-object v4, v3

    move-object v5, p1

    move-object v6, v0

    move-object v7, p0

    move v8, p2

    move-object v9, p3

    invoke-direct/range {v4 .. v9}, Lchat/ola/vn/activity/OlaCropImageActivity$6;-><init>(Ljava/lang/String;Landroid/app/Dialog;Landroid/content/Context;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance p0, Lchat/ola/vn/c/e;

    invoke-direct {p0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 p1, 0x1

    new-array p1, p1, [Lchat/ola/vn/c/f;

    aput-object v2, p1, v1

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V

    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-interface {p3}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->G()V

    return-void
.end method

.method static synthetic c(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    sget v0, Lchat/ola/vn/e;->c:I

    invoke-static {p1}, Lchat/ola/vn/entity/i;->b(Ljava/lang/String;)[I

    move-result-object v1

    const/4 v2, 0x0

    :try_start_0
    aget v2, v1, v2

    const/4 v3, 0x1

    aget v1, v1, v3

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    :catch_0
    invoke-static {p1}, Lchat/ola/vn/entity/i;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static d(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 10

    new-instance v0, Lchat/ola/vn/activity/OlaCropImageActivity$9;

    invoke-direct {v0, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$9;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    const v1, 0x7f0f023d

    const-wide/32 v2, 0x2bf20

    invoke-static {p0, v1, v2, v3, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p1, p2, v1}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;IZ)Lchat/ola/vn/c/f;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/activity/OlaCropImageActivity$10;

    move-object v4, v3

    move-object v5, p1

    move-object v6, v0

    move-object v7, p0

    move v8, p2

    move-object v9, p3

    invoke-direct/range {v4 .. v9}, Lchat/ola/vn/activity/OlaCropImageActivity$10;-><init>(Ljava/lang/String;Landroid/app/Dialog;Landroid/content/Context;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance p0, Lchat/ola/vn/c/e;

    invoke-direct {p0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 p1, 0x1

    new-array p1, p1, [Lchat/ola/vn/c/f;

    aput-object v2, p1, v1

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V

    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-interface {p3}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->F()V

    return-void
.end method

.method private static d(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 4

    new-instance v0, Lchat/ola/vn/activity/OlaCropImageActivity$7;

    invoke-direct {v0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$7;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    const v1, 0x7f0f023d

    const-wide/32 v2, 0x2bf20

    invoke-static {p0, v1, v2, v3, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IJLjava/lang/Runnable;)Lchat/ola/vn/i/c;

    move-result-object v0

    sget v1, Lchat/ola/vn/e;->c:I

    const/4 v2, 0x0

    invoke-static {p1, v1, v2}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;IZ)Lchat/ola/vn/c/f;

    move-result-object v1

    new-instance v3, Lchat/ola/vn/activity/OlaCropImageActivity$8;

    invoke-direct {v3, p1, v0, p0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$8;-><init>(Ljava/lang/String;Landroid/app/Dialog;Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-virtual {v1, v3}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance p0, Lchat/ola/vn/c/e;

    invoke-direct {p0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 p1, 0x1

    new-array p1, p1, [Lchat/ola/vn/c/f;

    aput-object v1, p1, v2

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V

    invoke-virtual {v0}, Landroid/app/Dialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-interface {p2}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->G()V

    return-void
.end method

.method public static e(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static e(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaCropImageActivity$11;

    invoke-direct {v0, p0, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$11;-><init>(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p1, p2, p2, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method private static e(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 3

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    new-instance v2, Lchat/ola/vn/activity/OlaCropImageActivity$3;

    invoke-direct {v2, p0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$3;-><init>(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p1, v0, v1, v2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method public static f(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method private static f(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    mul-int/lit8 v0, p2, 0x9

    div-int/lit8 v0, v0, 0x10

    new-instance v1, Lchat/ola/vn/activity/OlaCropImageActivity$12;

    invoke-direct {v1, p0, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$12;-><init>(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p1, p2, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method private static f(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 3

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    new-instance v2, Lchat/ola/vn/activity/OlaCropImageActivity$4;

    invoke-direct {v2, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$4;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    invoke-static {p0, p1, v0, v1, v2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;IILchat/ola/vn/activity/OlaCropImageActivity$b;)V

    return-void
.end method

.method public static g(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->d(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method

.method public static h(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/activity/OlaCropImageActivity;->C()I

    move-result v0

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    const/4 v0, -0x1

    if-ne p2, v0, :cond_2

    const/4 p2, 0x1

    if-ne p1, p2, :cond_0

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    return-void

    :cond_0
    const/4 p2, 0x2

    if-ne p1, p2, :cond_3

    :try_start_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->finish()V

    return-void

    :cond_1
    new-instance p2, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->m()Ljava/io/File;

    move-result-object p3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ".crop."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ".tmp"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p2, p3, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lcom/mg/ola/common/d/c;->a(Landroid/content/Context;Landroid/net/Uri;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->B()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :cond_2
    :goto_0
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->finish()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    return-void

    :cond_3
    const/4 p2, 0x3

    if-ne p1, p2, :cond_5

    :try_start_3
    const-string p1, "outputPath"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_4

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_1

    :cond_4
    new-instance p2, Ljava/io/File;

    sget-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    :goto_1
    sget-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->j:Lchat/ola/vn/activity/OlaCropImageActivity$b;

    if-eqz p1, :cond_2

    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/activity/OlaCropImageActivity;->j:Lchat/ola/vn/activity/OlaCropImageActivity$b;

    invoke-interface {p2, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$b;->a(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :catch_1
    move-exception p1

    :try_start_4
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    :catch_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->finish()V

    :cond_5
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0150

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity;->setContentView(I)V

    sget-boolean p1, Lchat/ola/vn/activity/OlaCropImageActivity;->i:Z

    if-eqz p1, :cond_2

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/activity/OlaCropImageActivity;->i:Z

    sget-object p1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->B()V

    return-void

    :cond_0
    sget p1, Lchat/ola/vn/activity/OlaCropImageActivity;->e:I

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v0, "image/*"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    const-string v0, "android.intent.action.GET_CONTENT"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const v0, 0x7f0f060c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object p1

    const/4 v0, 0x2

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaCropImageActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void

    :pswitch_1
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v0, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_1
    invoke-static {v0}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    const-string v0, "output"

    sget-object v1, Lchat/ola/vn/activity/OlaCropImageActivity;->h:Landroid/net/Uri;

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const-string v0, "return-data"

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    invoke-virtual {p0, p1, v1}, Lchat/ola/vn/activity/OlaCropImageActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method
