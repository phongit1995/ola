.class public Lchat/ola/vn/activity/ClanManagementActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;


# static fields
.field private static e:Lchat/ola/vn/entity/b;


# instance fields
.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method static synthetic I()Lchat/ola/vn/entity/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    return-object v0
.end method

.method private J()V
    .locals 1

    const v0, 0x7f0b0051

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->setContentView(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090170

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09016b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090174

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090172

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f09016c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->f:Landroid/widget/TextView;

    const v0, 0x7f09016a

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->g:Landroid/widget/TextView;

    const v0, 0x7f090173

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->h:Landroid/widget/TextView;

    const v0, 0x7f090171

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->i:Landroid/widget/TextView;

    const v0, 0x7f0905de

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905be

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private K()V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->f:Landroid/widget/TextView;

    const v1, 0x7f0f0666

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->L()V

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->M()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private L()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->j:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->j:Landroid/widget/TextView;

    const v1, 0x7f0f0553

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->f:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->g:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_1

    :goto_2
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->g:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    :goto_3
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->g:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_3

    :goto_4
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->h:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    :goto_5
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->h:Landroid/widget/TextView;

    const-string v1, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    :catch_0
    return-void
.end method

.method private M()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/ClanManagementActivity;->i:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-short v1, v1, Lchat/ola/vn/entity/b;->j:S

    invoke-static {p0, v1}, Lchat/ola/vn/util/m;->a(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private N()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f01e2

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f01e1

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f01e3

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f01e4

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f01e0

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/ClanManagementActivity$7;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/activity/ClanManagementActivity$7;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-short v0, v0, Lchat/ola/vn/entity/b;->j:S

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/4 v2, 0x3

    goto :goto_0

    :pswitch_1
    const/4 v2, 0x4

    goto :goto_0

    :pswitch_2
    const/4 v2, 0x2

    goto :goto_0

    :pswitch_3
    const/4 v2, 0x1

    :goto_0
    :pswitch_4
    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(I)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/b;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    sput-object p1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/ClanManagementActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

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

.method static synthetic a(Lchat/ola/vn/activity/ClanManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->L()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/ClanManagementActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->M()V

    return-void
.end method


# virtual methods
.method protected B()V
    .locals 11

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v2, ""

    const/4 v3, 0x0

    const v4, 0x7f0f068d

    const v5, 0x7f0f00ca

    const v6, 0x7f0f068c

    const v7, 0x7f0f044d

    const/4 v8, 0x0

    new-instance v9, Lchat/ola/vn/activity/ClanManagementActivity$3;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/ClanManagementActivity$3;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    new-instance v10, Lchat/ola/vn/activity/ClanManagementActivity$4;

    invoke-direct {v10, p0}, Lchat/ola/vn/activity/ClanManagementActivity$4;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected C()V
    .locals 10

    :try_start_0
    const-string v1, ""

    const/4 v2, 0x0

    const v3, 0x7f0f067b

    const v4, 0x7f0f00ca

    const v5, 0x7f0f067c

    const v6, 0x7f0f044d

    const/4 v7, 0x0

    new-instance v8, Lchat/ola/vn/activity/ClanManagementActivity$5;

    invoke-direct {v8, p0}, Lchat/ola/vn/activity/ClanManagementActivity$5;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    new-instance v9, Lchat/ola/vn/activity/ClanManagementActivity$6;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/ClanManagementActivity$6;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v9}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public D()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->K()V

    return-void
.end method

.method public E()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->K()V

    return-void
.end method

.method public F()V
    .locals 0

    return-void
.end method

.method public G()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->K()V

    return-void
.end method

.method public b_()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/ClanManagementActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 11

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    sget-object p1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->B()V

    return-void

    :sswitch_1
    sget-object p1, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->C()V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->finish()V

    return-void

    :sswitch_3
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->b()Ljava/util/List;

    move-result-object v8

    const/4 v1, 0x0

    const v2, 0x7f08069f

    const v3, 0x7f0f047d

    const v4, 0x7f0f00ca

    const v5, 0x7f0f0585

    const v6, 0x7f0f044d

    const/16 v7, 0x20

    new-instance v9, Lchat/ola/vn/activity/ClanManagementActivity$2;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/ClanManagementActivity$2;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    const/4 v10, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    :goto_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/i/p;->e(Ljava/lang/String;)V

    return-void

    :sswitch_4
    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->N()V

    return-void

    :sswitch_5
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->b()Ljava/util/List;

    move-result-object v8

    const/4 v1, 0x0

    const v2, 0x7f0806a0

    const v3, 0x7f0f0477

    const v4, 0x7f0f00ca

    const v5, 0x7f0f0585

    const v6, 0x7f0f044d

    const/16 v7, 0x20

    new-instance v9, Lchat/ola/vn/activity/ClanManagementActivity$1;

    invoke-direct {v9, p0}, Lchat/ola/vn/activity/ClanManagementActivity$1;-><init>(Lchat/ola/vn/activity/ClanManagementActivity;)V

    const/4 v10, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;Lchat/ola/vn/i/p$a;)Lchat/ola/vn/i/p;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/activity/ClanManagementActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f09016b -> :sswitch_5
        0x7f090172 -> :sswitch_4
        0x7f090174 -> :sswitch_3
        0x7f09039c -> :sswitch_2
        0x7f0905be -> :sswitch_1
        0x7f0905de -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->J()V

    invoke-direct {p0}, Lchat/ola/vn/activity/ClanManagementActivity;->K()V

    return-void
.end method
