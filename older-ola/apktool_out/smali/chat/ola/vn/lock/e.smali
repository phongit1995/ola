.class public Lchat/ola/vn/lock/e;
.super Lchat/ola/vn/lock/d;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field protected a:Landroid/widget/TextView;

.field protected b:Landroid/widget/TextView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/widget/TextView;

.field protected e:Landroid/view/View;

.field private f:Lchat/ola/vn/lock/d;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/lock/d;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/lock/e;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/lock/e;->x()V

    return-void
.end method

.method private x()V
    .locals 8

    sget-object v0, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    iget-object v0, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/lock/e;->a:Landroid/widget/TextView;

    const v3, 0x7f0f0661

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->c:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->e:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setEnabled(Z)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/lock/e;->a:Landroid/widget/TextView;

    const v3, 0x7f0f0662

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->c:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/lock/e;->e:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setEnabled(Z)V

    :goto_0
    sget-wide v3, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/16 v5, 0x0

    cmp-long v0, v3, v5

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    const v1, 0x7f0f051d

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_1
    sget-wide v3, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v5, 0xea60

    cmp-long v0, v3, v5

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    const v3, 0x7f0f0416

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "1"

    aput-object v4, v2, v1

    :goto_1
    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    sget-wide v3, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v5, 0x493e0

    cmp-long v0, v3, v5

    const v3, 0x7f0f0417

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "5"

    aput-object v4, v2, v1

    goto :goto_1

    :cond_3
    sget-wide v4, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v6, 0xdbba0

    cmp-long v0, v4, v6

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "15"

    aput-object v4, v2, v1

    goto :goto_1

    :cond_4
    sget-wide v3, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v5, 0x36ee80

    cmp-long v0, v3, v5

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    const v3, 0x7f0f0414

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "1"

    aput-object v4, v2, v1

    goto :goto_1

    :cond_5
    sget-wide v3, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v5, 0xdbba00

    cmp-long v0, v3, v5

    if-nez v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    const v3, 0x7f0f0415

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "4"

    aput-object v4, v2, v1

    goto :goto_1

    :cond_6
    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/lock/d;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f042c

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0598

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public h()Lchat/ola/vn/lock/d;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/lock/e;->f:Lchat/ola/vn/lock/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public j()Lchat/ola/vn/lock/d;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09014d

    if-eq p1, v0, :cond_3

    const v0, 0x7f09041b

    if-eq p1, v0, :cond_2

    const v0, 0x7f0904e1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    if-eqz p1, :cond_1

    iget-object p1, p1, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v0, Lchat/ola/vn/lock/g;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/lock/g;

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/lock/e;->f:Lchat/ola/vn/lock/d;

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v0, Lchat/ola/vn/lock/c;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/lock/c;

    goto :goto_0

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->y()Lchat/ola/vn/lock/OlaPasscodeSettingActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->B()V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->v()V

    return-void

    :cond_3
    sget-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    if-eqz p1, :cond_4

    iget-object p1, p1, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-class v0, Lchat/ola/vn/lock/b;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/lock/b;

    iput-object p1, p0, Lchat/ola/vn/lock/e;->f:Lchat/ola/vn/lock/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_4
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b0162

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f0904e1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/e;->a:Landroid/widget/TextView;

    const p2, 0x7f09014d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    const p2, 0x7f09041a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/e;->c:Landroid/widget/TextView;

    const p2, 0x7f090419

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/lock/e;->a:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/lock/e;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09041b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/lock/e;->e:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/lock/e;->e:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/lock/e;->x()V

    return-object p1
.end method

.method public v()V
    .locals 13

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-wide v1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    const v1, 0x7f0f0415

    const v2, 0x7f0f0414

    const v3, 0x7f0f0416

    const v4, 0x7f0f051d

    const v6, 0x7f0f0417

    const/4 v7, 0x0

    const/4 v8, 0x1

    if-nez v5, :cond_0

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setText(I)V

    goto :goto_2

    :cond_0
    sget-wide v9, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v11, 0xea60

    cmp-long v5, v9, v11

    if-nez v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v9, v8, [Ljava/lang/Object;

    const-string v10, "1"

    aput-object v10, v9, v7

    invoke-virtual {p0, v3, v9}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    :goto_0
    invoke-virtual {v5, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_1
    sget-wide v9, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v11, 0x493e0

    cmp-long v5, v9, v11

    if-nez v5, :cond_2

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v9, v8, [Ljava/lang/Object;

    const-string v10, "5"

    aput-object v10, v9, v7

    :goto_1
    invoke-virtual {p0, v6, v9}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    goto :goto_0

    :cond_2
    sget-wide v9, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v11, 0xdbba0

    cmp-long v5, v9, v11

    if-nez v5, :cond_3

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v9, v8, [Ljava/lang/Object;

    const-string v10, "15"

    aput-object v10, v9, v7

    goto :goto_1

    :cond_3
    sget-wide v9, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v11, 0x36ee80

    cmp-long v5, v9, v11

    if-nez v5, :cond_4

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v9, v8, [Ljava/lang/Object;

    const-string v10, "1"

    aput-object v10, v9, v7

    invoke-virtual {p0, v2, v9}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    goto :goto_0

    :cond_4
    sget-wide v9, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    const-wide/32 v11, 0xdbba00

    cmp-long v5, v9, v11

    if-nez v5, :cond_5

    iget-object v5, p0, Lchat/ola/vn/lock/e;->d:Landroid/widget/TextView;

    new-array v9, v8, [Ljava/lang/Object;

    const-string v10, "4"

    aput-object v10, v9, v7

    invoke-virtual {p0, v1, v9}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    goto :goto_0

    :cond_5
    :goto_2
    invoke-virtual {p0, v4}, Lchat/ola/vn/lock/e;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v4, v8, [Ljava/lang/Object;

    const-string v5, "1"

    aput-object v5, v4, v7

    invoke-virtual {p0, v3, v4}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v3, v8, [Ljava/lang/Object;

    const-string v4, "5"

    aput-object v4, v3, v7

    invoke-virtual {p0, v6, v3}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v3, v8, [Ljava/lang/Object;

    const-string v4, "15"

    aput-object v4, v3, v7

    invoke-virtual {p0, v6, v3}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v3, v8, [Ljava/lang/Object;

    const-string v4, "1"

    aput-object v4, v3, v7

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v2, v8, [Ljava/lang/Object;

    const-string v3, "4"

    aput-object v3, v2, v7

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/lock/e;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/lock/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/lock/e$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/lock/e$1;-><init>(Lchat/ola/vn/lock/e;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method
