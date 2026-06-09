.class public final enum Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "UndoStyle"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

.field public static final enum b:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

.field public static final enum c:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

.field private static final synthetic d:[Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const-string v1, "SINGLE_POPUP"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const-string v1, "MULTILEVEL_POPUP"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->b:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const-string v1, "COLLAPSED_POPUP"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->c:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const/4 v0, 0x3

    new-array v0, v0, [Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    aput-object v1, v0, v2

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->b:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    aput-object v1, v0, v3

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->c:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    aput-object v1, v0, v4

    sput-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->d:[Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;
    .locals 1

    const-class v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    return-object p0
.end method

.method public static values()[Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;
    .locals 1

    sget-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->d:[Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    invoke-virtual {v0}, [Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    return-object v0
.end method
