.class public Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/network/a/a/ai$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;,
        Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$b;
    }
.end annotation


# static fields
.field private static g:Ljava/lang/String;

.field private static h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static k:I


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;

.field private i:Landroid/view/View;

.field private j:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 2

    const v0, 0x7f090009

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->i:Landroid/view/View;

    const v0, 0x7f090088

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09000f

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget v0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->k:I

    if-lez v0, :cond_0

    const v0, 0x7f0904e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :cond_0
    new-instance v0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;

    invoke-direct {v0, p0, p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->f:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->f:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;

    sget-object v1, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->h:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->f:Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->e:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-void
.end method

.method private C()V
    .locals 5

    invoke-static {p0}, Lcom/mg/ola/common/d/g;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "1900588883"

    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    const v0, 0x7f0f00a2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f036c

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "1900588883"

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void
.end method

.method public static a(Landroid/app/Activity;Ljava/lang/String;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->a(Landroid/app/Activity;Ljava/lang/String;Ljava/util/List;I)V

    return-void
.end method

.method public static a(Landroid/app/Activity;Ljava/lang/String;Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    sput-object p1, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->g:Ljava/lang/String;

    sput-object p2, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->h:Ljava/util/List;

    sput p3, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->k:I

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const/4 p2, 0x7

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    const p1, 0x7f010038

    const p2, 0x7f010039

    :try_start_0
    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->C()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->i:Landroid/view/View;

    return-object p0
.end method

.method private c(Z)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->j:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$2;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->j:Ljava/lang/Runnable;

    :cond_0
    const-wide/32 v0, 0xea60

    iget-object v2, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->j:Ljava/lang/Runnable;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->i:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->j:Ljava/lang/Runnable;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->i:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x1

    :try_start_0
    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "_username"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_pass"

    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 p1, -0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string p2, "Reset Pass OK"

    invoke-virtual {p1, p2}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a_(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->c(Z)V

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c_()V
    .locals 7

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->c(Z)V

    new-instance v6, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity$1;-><init>(Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;)V

    const v2, 0x7f0f009f

    const v3, 0x7f0f025b

    const v4, 0x7f0f002c

    const v5, 0x7f0f0480

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090088

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0168

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->B()V

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

    const/4 p1, 0x1

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->c(Z)V

    sget-object p1, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->h:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object p3, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->g:Ljava/lang/String;

    invoke-virtual {p2, p1, p3, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/a/a/ai$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
