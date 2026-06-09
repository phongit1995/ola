.class public Lchat/ola/vn/activity/OlaVipStoreActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# static fields
.field private static j:Ljava/lang/String;


# instance fields
.field protected e:Lchat/ola/vn/entity/ah;

.field protected f:Ljava/lang/Integer;

.field protected g:Ljava/lang/Short;

.field protected h:Ljava/lang/Long;

.field protected i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;"
        }
    .end annotation
.end field

.field private k:Landroid/widget/TextView;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/widget/TextView;

.field private n:Landroid/widget/ListView;

.field private o:Landroid/widget/ImageView;

.field private p:[Ljava/lang/String;

.field private q:Ljava/text/SimpleDateFormat;

.field private r:Lchat/ola/vn/b/ad;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/ImageView;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/view/View;

.field private x:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    return-void
.end method

.method private D()Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :catch_0
    :cond_1
    return v0
.end method

.method private E()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    aget-object v2, v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/activity/OlaVipStoreActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaVipStoreActivity$1;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private F()V
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    sput-object p1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v0, 0x20000

    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaVipStoreActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->F()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaVipStoreActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->c(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/entity/ah;Landroid/view/View;)V
    .locals 2

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->g()Z

    move-result v0

    if-nez v0, :cond_0

    const v0, 0x7f0f0684

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->f()Z

    move-result v0

    if-eqz v0, :cond_1

    const v0, 0x7f0f0676

    :goto_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const v0, 0x7f0f0546

    goto :goto_0

    :goto_1
    const v0, 0x7f0f0657

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f04b3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/activity/OlaVipStoreActivity$2;

    invoke-direct {v1, p0, p2, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity$2;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Ljava/util/List;Lchat/ola/vn/entity/ah;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private c(Lchat/ola/vn/entity/ah;)V
    .locals 0

    return-void
.end method

.method private c(Z)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->x:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaVipStoreActivity$6;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->x:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->x:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->w:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->w:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->x:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->w:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method private f(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    new-instance v1, Lchat/ola/vn/activity/OlaVipStoreActivity$5;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity$5;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Ljava/lang/String;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->j(Ljava/lang/String;S)V

    :cond_0
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->c(Z)V

    return-void
.end method


# virtual methods
.method public B()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->i:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ad;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    invoke-virtual {v0}, Lchat/ola/vn/b/ad;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->b()I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ad;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ad;->a(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->D()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->o:Landroid/widget/ImageView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->o:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v3}, Lchat/ola/vn/entity/ah;->b()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->k:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->l:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->q:Ljava/text/SimpleDateFormat;

    new-instance v3, Ljava/util/Date;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->h:Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->i:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->u:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const v5, 0x7f0f06ac

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->g:Ljava/lang/Short;

    invoke-virtual {v2}, Ljava/lang/Short;->shortValue()S

    move-result v2

    packed-switch v2, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->m:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    const/4 v3, 0x2

    aget-object v2, v2, v3

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->m:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    aget-object v2, v2, v1

    :goto_1
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :pswitch_2
    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->m:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    aget-object v0, v3, v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->s:Landroid/widget/TextView;

    const v2, 0x7f0f03b2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_3

    :cond_2
    sget-object v0, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v3, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->s:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->v:Landroid/widget/TextView;

    const v1, 0x7f0f06ab

    :goto_4
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-lez v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-le v0, v1, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->v:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f04a4

    :goto_5
    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->v:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f04a3

    goto :goto_5

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->v:Landroid/widget/TextView;

    const v1, 0x7f0f06aa

    goto :goto_4

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected C()V
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method protected a(Lchat/ola/vn/entity/ah;)V
    .locals 5

    new-instance v0, Lchat/ola/vn/i/e;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/e;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f0684

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/e;->setTitle(I)V

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->b()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/e;->a(Landroid/graphics/Bitmap;)V

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const v3, 0x7f0f0175

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/e;->a(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/e;->a(I)V

    const v1, 0x7f0f044d

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/e;->b(I)V

    new-instance v1, Lchat/ola/vn/activity/OlaVipStoreActivity$3;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity$3;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Lchat/ola/vn/entity/ah;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/e;->a(Landroid/content/DialogInterface$OnClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/e;->show()V

    return-void
.end method

.method public a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IS",
            "Ljava/lang/String;",
            "J",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->c(Z)V

    sput-object p1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    if-eqz p2, :cond_0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->f:Ljava/lang/Integer;

    goto :goto_1

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    :goto_1
    invoke-static {p3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->g:Ljava/lang/Short;

    invoke-static {p5, p6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->h:Ljava/lang/Long;

    iput-object p7, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->i:Ljava/util/List;

    invoke-interface {p7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/ah;

    invoke-virtual {p2}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p3, p4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_2

    iput-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->e:Lchat/ola/vn/entity/ah;

    :cond_2
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p3

    invoke-virtual {p2}, Lchat/ola/vn/entity/ah;->b()I

    move-result p5

    invoke-virtual {p3, p5}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p3

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/entity/ah;->a(Ljava/lang/String;)V

    goto :goto_2

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->B()V

    return-void
.end method

.method protected b(Lchat/ola/vn/entity/ah;)V
    .locals 5

    new-instance v0, Lchat/ola/vn/i/f;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/f;-><init>(Landroid/content/Context;)V

    const v1, 0x7f0f04b3

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/f;->setTitle(I)V

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->b()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/f;->a(Landroid/graphics/Bitmap;)V

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const v3, 0x7f0f022e

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/f;->a(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/f;->a(I)V

    const v1, 0x7f0f044d

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/f;->b(I)V

    new-instance v1, Lchat/ola/vn/activity/OlaVipStoreActivity$4;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity$4;-><init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Lchat/ola/vn/entity/ah;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/f;->a(Landroid/content/DialogInterface$OnClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/f;->show()V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ah;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->c(Lchat/ola/vn/entity/ah;)V

    return-void

    :sswitch_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->E()V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->finish()V

    return-void

    :sswitch_3
    invoke-static {p0}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;)V

    return-void

    :sswitch_4
    invoke-static {p0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090142 -> :sswitch_4
        0x7f09020a -> :sswitch_3
        0x7f09020b -> :sswitch_3
        0x7f09039c -> :sswitch_2
        0x7f0903a1 -> :sswitch_2
        0x7f0903dd -> :sswitch_1
        0x7f0905ef -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b01d0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->setContentView(I)V

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->s:Landroid/widget/TextView;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->t:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->t:Landroid/widget/ImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->t:Landroid/widget/ImageView;

    const v0, 0x7f080640

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    const p1, 0x7f090609

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->w:Landroid/view/View;

    const p1, 0x7f090309

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->n:Landroid/widget/ListView;

    const p1, 0x7f0905ee

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->v:Landroid/widget/TextView;

    const p1, 0x7f09020a

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->D()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    const v0, 0x7f0b01d2

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f0905ef

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->o:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->o:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090142

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09020b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905f5

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->k:Landroid/widget/TextView;

    const v0, 0x7f0905f6

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->l:Landroid/widget/TextView;

    const v0, 0x7f0903dd

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903dc

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->m:Landroid/widget/TextView;

    const v0, 0x7f0902ca

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->u:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->u:Landroid/widget/TextView;

    const v1, 0x7f0f06ae

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->n:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->t:Landroid/widget/ImageView;

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->n:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f030015

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->p:[Ljava/lang/String;

    new-instance p1, Ljava/text/SimpleDateFormat;

    const-string v0, "dd-MM-yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->q:Ljava/text/SimpleDateFormat;

    new-instance p1, Lchat/ola/vn/b/ad;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/ad;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ad;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->n:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    sget-object p1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    sget-object p1, Lchat/ola/vn/activity/OlaVipStoreActivity;->j:Ljava/lang/String;

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->f(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->B()V

    return-void
.end method

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity;->r:Lchat/ola/vn/b/ad;

    add-int/lit8 p3, p3, -0x1

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/ad;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaVipStoreActivity;->D()Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/entity/ah;Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
