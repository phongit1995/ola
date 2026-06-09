.class Lchat/ola/vn/activity/CreateClanActivity$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/CreateClanActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Landroid/widget/TextView;

.field b:Landroid/widget/TextView;

.field c:Landroid/widget/TextView;

.field d:Landroid/widget/TextView;

.field e:Landroid/widget/TextView;

.field f:Landroid/widget/TextView;

.field final synthetic g:Lchat/ola/vn/activity/CreateClanActivity;

.field private h:Landroid/view/View;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/CreateClanActivity;Landroid/view/View;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->g:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->h:Landroid/view/View;

    const v0, 0x7f090508

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->f:Landroid/widget/TextView;

    const v0, 0x7f090506

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->a:Landroid/widget/TextView;

    const v0, 0x7f09050b

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->b:Landroid/widget/TextView;

    const v0, 0x7f090507

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->c:Landroid/widget/TextView;

    const v0, 0x7f09050a

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->d:Landroid/widget/TextView;

    const v0, 0x7f09050d

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->e:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->a:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->c:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/CreateClanActivity$a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity$a;->b()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/CreateClanActivity$a;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    .locals 0

    invoke-direct/range {p0 .. p6}, Lchat/ola/vn/activity/CreateClanActivity$a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->f:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->a:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, p4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->d:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long p3, p5

    invoke-static {p3, p4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->g:Lchat/ola/vn/activity/CreateClanActivity;

    const p4, 0x7f0f0566

    invoke-virtual {p3, p4}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->e:Landroid/widget/TextView;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long p3, p6

    invoke-static {p3, p4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->g:Lchat/ola/vn/activity/CreateClanActivity;

    const p4, 0x7f0f06b1

    invoke-virtual {p3, p4}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity$a;->b()V

    return-void
.end method

.method private b()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/CreateClanActivity$a;->h:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/CreateClanActivity$a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/CreateClanActivity$a;->a()V

    return-void
.end method
