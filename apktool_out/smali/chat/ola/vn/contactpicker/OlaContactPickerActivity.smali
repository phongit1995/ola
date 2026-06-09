.class public Lchat/ola/vn/contactpicker/OlaContactPickerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;,
        Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;,
        Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;
    }
.end annotation


# static fields
.field private static j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private static k:Ljava/lang/String;

.field private static l:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;


# instance fields
.field private e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private f:Lit/sephiroth/android/library/widget/HListView;

.field private g:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

.field private h:Landroid/widget/ListView;

.field private i:Lchat/ola/vn/contactpicker/a;

.field private m:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private n:Landroid/widget/TextView;

.field private o:Lchat/ola/vn/b/q;

.field private p:Landroid/app/ProgressDialog;

.field private q:Ljava/lang/Runnable;

.field private r:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f:Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->r:Z

    return-void
.end method

.method static synthetic B()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    return-object v0
.end method

.method static synthetic C()Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
    .locals 1

    sget-object v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->l:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;

    return-object v0
.end method

.method private D()V
    .locals 7

    const v0, 0x7f0901bc

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    const v0, 0x7f09045f

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f:Lit/sephiroth/android/library/widget/HListView;

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->n:Landroid/widget/TextView;

    sget-object v2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->k:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    const v0, 0x7f0901bb

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    new-instance v2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$1;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f0f04da

    :try_start_0
    sget-object v2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v2, v2, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v3, 0x7f0f04dc

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    iget-object v2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    :goto_1
    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->o:Lchat/ola/vn/b/q;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->o:Lchat/ola/vn/b/q;

    new-instance v2, Lchat/ola/vn/b/q$a;

    iget-object v3, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->o:Lchat/ola/vn/b/q;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v2, v3}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    sget-object v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    if-eqz v0, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    sget-object v2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    sget-object v2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    new-instance v4, Lchat/ola/vn/entity/x;

    invoke-direct {v4}, Lchat/ola/vn/entity/x;-><init>()V

    iput-byte v1, v4, Lchat/ola/vn/entity/x;->a:B

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "@"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iput-object v5, v4, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v4, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->o:Lchat/ola/vn/b/q;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->o:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const v2, 0x7f0f0603

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private E()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/contactpicker/a;

    invoke-direct {v0, p0}, Lchat/ola/vn/contactpicker/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    sget-object v1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/contactpicker/a;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    new-instance v1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    iput-object v1, v0, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private F()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f:Lit/sephiroth/android/library/widget/HListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->g:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    invoke-direct {v0, p0, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->g:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f:Lit/sephiroth/android/library/widget/HListView;

    iget-object v1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->g:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->g:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    invoke-virtual {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->notifyDataSetChanged()V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f:Lit/sephiroth/android/library/widget/HListView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->setVisibility(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    .locals 7

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->e()Ljava/util/List;

    move-result-object v2

    const v0, 0x7f0f0465

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p0

    move-object v6, p1

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;",
            ")V"
        }
    .end annotation

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->e()Ljava/util/List;

    move-result-object v2

    const v0, 0x7f0f0526

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    move-object v1, p0

    move-object v5, p1

    move-object v6, p2

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;",
            ")V"
        }
    .end annotation

    :try_start_0
    sput-object p1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    sget-object p1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    sput-object p1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    :cond_0
    sget-object p1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    if-eqz p1, :cond_3

    if-eqz p4, :cond_3

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1, p4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    sget-object p3, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->j:Ljava/util/List;

    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_1
    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_3

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lchat/ola/vn/message/f;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p3}, Ljava/util/Iterator;->remove()V

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_3
    sput-object p2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->k:Ljava/lang/String;

    sput-object p5, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->l:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_1
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010036

    const p2, 0x7f01003d

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->i:Lchat/ola/vn/contactpicker/a;

    return-object p0
.end method

.method public static b(Landroid/content/Context;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    .locals 7

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->e()Ljava/util/List;

    move-result-object v2

    const v0, 0x7f0f040a

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p0

    move-object v6, p1

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->r:Z

    return p1
.end method

.method private c(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->q:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$4;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    iput-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->q:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->q:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_2

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    const p1, 0x7f0f05ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f01d8

    invoke-virtual {p0, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->q:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->r:Z

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->F()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->p:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_1

    return-void

    :catch_0
    :cond_1
    const/4 v0, 0x0

    :try_start_1
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x1

    invoke-direct {p0, v2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->c(Z)V

    if-eqz v1, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, v0

    new-instance v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;

    invoke-direct {v0, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    invoke-virtual {v1, p1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;-><init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->E()V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->overridePendingTransition(II)V
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

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_3

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_1

    const v0, 0x7f0903a3

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->h:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_1
    const/4 p1, 0x0

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p1, v0

    :catch_0
    :try_start_2
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->r:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f(Ljava/lang/String;)V

    return-void

    :cond_2
    sget-object p1, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->l:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->m:Ljava/util/List;

    invoke-interface {p1, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;->h(Ljava/util/List;)V

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->finish()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b014f

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->D()V

    return-void
.end method
